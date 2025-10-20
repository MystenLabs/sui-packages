module 0x89234dc607c8827ad57fb5d11d34f296271bf984a8aa37543b3e76b4a8baaf15::carros {
    struct Carro has key {
        id: 0x2::object::UID,
        marca: 0x1::string::String,
        modelo: 0x1::string::String,
        color: 0x1::string::String,
    }

    public fun actualizar_color(arg0: &mut Carro, arg1: 0x1::string::String) {
        arg0.color = arg1;
    }

    public fun actualizar_modelo(arg0: &mut Carro, arg1: 0x1::string::String) {
        arg0.modelo = arg1;
    }

    public fun crear_carro(arg0: &mut 0x2::tx_context::TxContext, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String) : Carro {
        Carro{
            id     : 0x2::object::new(arg0),
            marca  : arg1,
            modelo : arg2,
            color  : arg3,
        }
    }

    public fun eliminar_carro(arg0: Carro) {
        let Carro {
            id     : v0,
            marca  : _,
            modelo : _,
            color  : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun obtener_marca(arg0: &Carro) : 0x1::string::String {
        arg0.marca
    }

    // decompiled from Move bytecode v6
}

