module 0xb0fb9ac7daf3f4cdfc509eb0ba54f602afcec6fa0916da01a337ecab28130099::curso {
    struct Operacion has key {
        id: 0x2::object::UID,
        primero: u64,
        segundo: u64,
        resultado: u64,
        tipo_operacion: 0x1::string::String,
    }

    public fun crear_operacion(arg0: &mut 0x2::tx_context::TxContext, arg1: u64, arg2: u64, arg3: 0x1::string::String) {
        let v0 = Operacion{
            id             : 0x2::object::new(arg0),
            primero        : arg1,
            segundo        : arg2,
            resultado      : 0,
            tipo_operacion : arg3,
        };
        0x2::transfer::transfer<Operacion>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun multiplicar(arg0: &mut Operacion) {
        arg0.resultado = arg0.primero * arg0.segundo;
    }

    public fun obtener_resultado(arg0: &Operacion) : u64 {
        arg0.resultado
    }

    public fun restar(arg0: &mut Operacion) {
        arg0.resultado = arg0.primero - arg0.segundo;
    }

    public fun sumar(arg0: &mut Operacion) {
        arg0.resultado = arg0.primero + arg0.segundo;
    }

    // decompiled from Move bytecode v6
}

