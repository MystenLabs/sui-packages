module 0x99ba2db66475583f6d62c7977a9bada4cef1e6e37681020540e95b94855ab0::alarmas_tiempo {
    struct SistemaAlarmas has key {
        id: 0x2::object::UID,
        propietario: address,
        alarmas: 0x2::table::Table<u64, Alarma>,
        contador: u64,
        alarmas_activadas: u64,
    }

    struct Alarma has store {
        id: u64,
        nombre: 0x1::string::String,
        hora_activacion: u64,
        repetir: bool,
        dias_repeticion: vector<u8>,
        activa: bool,
        sonido: u8,
        veces_sonado: u64,
    }

    public fun activar_alarma(arg0: &mut SistemaAlarmas, arg1: u64) {
        let v0 = 0x2::table::borrow_mut<u64, Alarma>(&mut arg0.alarmas, arg1);
        if (!v0.activa) {
            v0.activa = true;
            arg0.alarmas_activadas = arg0.alarmas_activadas + 1;
        };
    }

    public fun configurar_repeticion(arg0: &mut SistemaAlarmas, arg1: u64, arg2: u8) {
        let v0 = 0x2::table::borrow_mut<u64, Alarma>(&mut arg0.alarmas, arg1);
        if (!0x1::vector::contains<u8>(&v0.dias_repeticion, &arg2)) {
            0x1::vector::push_back<u8>(&mut v0.dias_repeticion, arg2);
        };
    }

    public fun crear_alarma(arg0: &mut SistemaAlarmas, arg1: vector<u8>, arg2: u64, arg3: bool, arg4: u8) {
        let v0 = Alarma{
            id              : arg0.contador,
            nombre          : 0x1::string::utf8(arg1),
            hora_activacion : arg2,
            repetir         : arg3,
            dias_repeticion : 0x1::vector::empty<u8>(),
            activa          : true,
            sonido          : arg4,
            veces_sonado    : 0,
        };
        0x2::table::add<u64, Alarma>(&mut arg0.alarmas, arg0.contador, v0);
        arg0.contador = arg0.contador + 1;
        arg0.alarmas_activadas = arg0.alarmas_activadas + 1;
    }

    public fun crear_sistema(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = SistemaAlarmas{
            id                : 0x2::object::new(arg0),
            propietario       : 0x2::tx_context::sender(arg0),
            alarmas           : 0x2::table::new<u64, Alarma>(arg0),
            contador          : 0,
            alarmas_activadas : 0,
        };
        0x2::transfer::transfer<SistemaAlarmas>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun desactivar_alarma(arg0: &mut SistemaAlarmas, arg1: u64) {
        let v0 = 0x2::table::borrow_mut<u64, Alarma>(&mut arg0.alarmas, arg1);
        if (v0.activa) {
            v0.activa = false;
            arg0.alarmas_activadas = arg0.alarmas_activadas - 1;
        };
    }

    public fun registrar_sonido(arg0: &mut SistemaAlarmas, arg1: u64) {
        let v0 = 0x2::table::borrow_mut<u64, Alarma>(&mut arg0.alarmas, arg1);
        v0.veces_sonado = v0.veces_sonado + 1;
    }

    public fun verificar_activacion(arg0: &SistemaAlarmas, arg1: u64, arg2: &0x2::clock::Clock) : bool {
        let v0 = 0x2::table::borrow<u64, Alarma>(&arg0.alarmas, arg1);
        if (!v0.activa) {
            return false
        };
        0x2::clock::timestamp_ms(arg2) >= v0.hora_activacion
    }

    // decompiled from Move bytecode v6
}

