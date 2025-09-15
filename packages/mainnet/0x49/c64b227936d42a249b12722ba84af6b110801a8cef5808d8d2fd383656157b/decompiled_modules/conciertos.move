module 0x49c64b227936d42a249b12722ba84af6b110801a8cef5808d8d2fd383656157b::conciertos {
    struct Concierto has key {
        id: 0x2::object::UID,
        nombre: 0x1::string::String,
        boletos: vector<Boleto>,
        lugares_disponibles: u32,
        lugares_vendidos: u32,
        contador_folios: u16,
        fecha: 0x1::string::String,
        flyer: 0x1::string::String,
        recinto: 0x1::string::String,
    }

    struct Boleto has drop, store {
        nombre: 0x1::string::String,
        folio: u16,
        edad: u16,
        fecha_compra: 0x1::string::String,
    }

    public entry fun agregar_boleto(arg0: &mut Concierto, arg1: 0x1::string::String, arg2: u16, arg3: 0x1::string::String) {
        let v0 = arg0.contador_folios;
        let v1 = Boleto{
            nombre       : arg1,
            folio        : v0,
            edad         : arg2,
            fecha_compra : arg3,
        };
        0x1::vector::push_back<Boleto>(&mut arg0.boletos, v1);
        arg0.lugares_vendidos = arg0.lugares_vendidos + 1;
        arg0.contador_folios = v0 + 1;
    }

    public fun crear_concierto(arg0: 0x1::string::String, arg1: u32, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = Concierto{
            id                  : 0x2::object::new(arg5),
            nombre              : arg0,
            boletos             : 0x1::vector::empty<Boleto>(),
            lugares_disponibles : arg1,
            lugares_vendidos    : 0,
            contador_folios     : 0,
            fecha               : arg2,
            flyer               : arg3,
            recinto             : arg4,
        };
        0x2::transfer::transfer<Concierto>(v0, 0x2::tx_context::sender(arg5));
    }

    public fun editar_boleto(arg0: &mut Concierto, arg1: u64, arg2: 0x1::string::String) {
        assert!(arg1 < 0x1::vector::length<Boleto>(&arg0.boletos), 13906834513645797377);
        0x1::vector::borrow_mut<Boleto>(&mut arg0.boletos, arg1).nombre = arg2;
    }

    public fun eliminar_boleto(arg0: &mut Concierto, arg1: u64) {
        assert!(arg1 < 0x1::vector::length<Boleto>(&arg0.boletos), 13906834578070306817);
        0x1::vector::remove<Boleto>(&mut arg0.boletos, arg1);
        arg0.lugares_vendidos = arg0.lugares_vendidos - 1;
    }

    public fun eliminar_concierto(arg0: Concierto) {
        let Concierto {
            id                  : v0,
            nombre              : _,
            boletos             : _,
            lugares_disponibles : _,
            lugares_vendidos    : _,
            contador_folios     : _,
            fecha               : _,
            flyer               : _,
            recinto             : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun eliminar_ultimo_concierto(arg0: &mut Concierto) {
        0x1::vector::pop_back<Boleto>(&mut arg0.boletos);
    }

    // decompiled from Move bytecode v6
}

