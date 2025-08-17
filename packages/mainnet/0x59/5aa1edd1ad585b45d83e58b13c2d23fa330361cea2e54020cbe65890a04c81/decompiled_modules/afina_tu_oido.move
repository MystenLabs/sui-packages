module 0x595aa1edd1ad585b45d83e58b13c2d23fa330361cea2e54020cbe65890a04c81::afina_tu_oido {
    struct DesafioMusical has store, key {
        id: 0x2::object::UID,
        nota_correcta: u8,
        respuesta: 0x1::option::Option<u8>,
        acerto: bool,
    }

    public fun cambiar_nota_correcta(arg0: &mut DesafioMusical, arg1: u8) {
        arg0.nota_correcta = arg1;
    }

    public entry fun crear_y_transferir(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = DesafioMusical{
            id            : 0x2::object::new(arg0),
            nota_correcta : 3,
            respuesta     : 0x1::option::none<u8>(),
            acerto        : false,
        };
        0x2::transfer::public_share_object<DesafioMusical>(v0);
    }

    public fun fue_acertado(arg0: &DesafioMusical) : bool {
        arg0.acerto
    }

    public fun obtener_respuesta(arg0: &DesafioMusical) : 0x1::option::Option<u8> {
        arg0.respuesta
    }

    public entry fun responder(arg0: &mut DesafioMusical, arg1: u8) {
        arg0.respuesta = 0x1::option::some<u8>(arg1);
        arg0.acerto = arg1 == arg0.nota_correcta;
    }

    // decompiled from Move bytecode v6
}

