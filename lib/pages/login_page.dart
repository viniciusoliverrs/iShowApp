import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;

import '../widgets/botao_animacao.dart';
import '../widgets/input_customizado.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation<double>? _animacaoBlur;
  Animation<double>? _animacaoFade;
  Animation<double>? _animacaoSize;

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(duration: const Duration(seconds: 1), vsync: this);

    _animacaoBlur = Tween<double>(begin: 5, end: 0)
        .animate(CurvedAnimation(parent: _controller!, curve: Curves.ease));

    _animacaoFade = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: _controller!, curve: Curves.easeInOutQuint));

    _animacaoSize = Tween<double>(begin: 0, end: 500).animate(
        CurvedAnimation(parent: _controller!, curve: Curves.decelerate));

    _controller!.forward();
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    timeDilation = 10;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              AnimatedBuilder(
                animation: _animacaoBlur!,
                builder: (context, widget) {
                  return Container(
                    height: 400,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/images/fundo.png"),
                            fit: BoxFit.fill)),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(
                          sigmaX: _animacaoBlur!.value,
                          sigmaY: _animacaoBlur!.value),
                      child: Stack(
                        children: <Widget>[
                          Positioned(
                            left: 10,
                            child: FadeTransition(
                              opacity: _animacaoFade!,
                              child: Image.asset("assets/images/detalhe1.png"),
                            ),
                          ),
                          Positioned(
                            left: 50,
                            child: FadeTransition(
                              opacity: _animacaoFade!,
                              child: Image.asset("assets/images/detalhe2.png"),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: Column(
                  children: <Widget>[
                    AnimatedBuilder(
                      animation: _animacaoSize!,
                      builder: (context, widget) {
                        return Container(
                          width: _animacaoSize!.value,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey[200]!,
                                    blurRadius: 15,
                                    spreadRadius: 4)
                              ]),
                          child: Column(
                            children: const <Widget>[
                              InputCustomizado(
                                hint: "Email",
                                obscure: false,
                                icon: Icon(Icons.person),
                              ),
                              InputCustomizado(
                                hint: "Senha",
                                obscure: true,
                                icon: Icon(Icons.lock),
                              )
                            ],
                          ),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    BotaoAnimado(
                      controller: _controller!,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    FadeTransition(
                      opacity: _animacaoFade!,
                      child: const Text(
                        "Esqueci minha senha!",
                        style: TextStyle(
                            color: Color.fromRGBO(255, 100, 127, 1),
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
