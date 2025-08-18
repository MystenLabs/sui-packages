module 0xe5efd8a882b0efe7689105bf42f853917b6aef4ed641285e27e6dae69c202f6b::batallanaval {
    struct Partida has store, key {
        id: 0x2::object::UID,
        jugador1: address,
        jugador2: address,
        turno: address,
        estado: u8,
        tablero1: vector<u8>,
        tablero2: vector<u8>,
        ataques1: vector<u8>,
        ataques2: vector<u8>,
        ganador: address,
    }

    public fun atacar(arg0: &mut Partida, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(arg0.estado == 1, 6);
        assert!(v0 == arg0.turno, 2);
        assert!(arg1 < 100, 3);
        let (v1, v2) = if (v0 == arg0.jugador1) {
            let v2 = &mut arg0.ataques1;
            let v1 = &mut arg0.tablero2;
            (v1, v2)
        } else {
            let v2 = &mut arg0.ataques2;
            let v1 = &mut arg0.tablero1;
            (v1, v2)
        };
        assert!(*0x1::vector::borrow<u8>(v2, arg1) == 0, 4);
        let v3 = 0x1::vector::borrow_mut<u8>(v1, arg1);
        let v4 = *v3;
        if (v4 == 0) {
            *0x1::vector::borrow_mut<u8>(v2, arg1) = 1;
        } else {
            *v3 = v4 + 10;
            *0x1::vector::borrow_mut<u8>(v2, arg1) = v4 + 10;
        };
        let v5 = if (arg0.turno == arg0.jugador1) {
            arg0.jugador2
        } else {
            arg0.jugador1
        };
        arg0.turno = v5;
        verificar_ganador(arg0);
    }

    public fun colocar_barco(arg0: &mut Partida, arg1: u64, arg2: u8, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(arg0.estado != 2, 6);
        assert!(arg1 < 100, 3);
        assert!(arg2 >= 1 && arg2 <= 5, 7);
        let v1 = if (v0 == arg0.jugador1) {
            &mut arg0.tablero1
        } else {
            assert!(v0 == arg0.jugador2, 5);
            &mut arg0.tablero2
        };
        if (arg3) {
            assert!(arg1 % 10 + (arg2 as u64) <= 10, 3);
        } else {
            assert!(arg1 / 10 + (arg2 as u64) <= 10, 3);
        };
        let v2 = 0;
        while (v2 < arg2) {
            let v3 = if (arg3) {
                arg1 + (v2 as u64)
            } else {
                arg1 + (v2 as u64) * 10
            };
            assert!(*0x1::vector::borrow<u8>(v1, v3) == 0, 8);
            *0x1::vector::borrow_mut<u8>(v1, v3) = arg2;
            v2 = v2 + 1;
        };
    }

    fun contar_barcos_activos(arg0: &vector<u8>) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v0 < 0x1::vector::length<u8>(arg0)) {
            let v2 = *0x1::vector::borrow<u8>(arg0, v0);
            if (v2 >= 1 && v2 <= 5) {
                v1 = v1 + 1;
            };
            v0 = v0 + 1;
        };
        v1
    }

    public fun crear_partida(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = Partida{
            id       : 0x2::object::new(arg0),
            jugador1 : v0,
            jugador2 : @0x0,
            turno    : v0,
            estado   : 0,
            tablero1 : 0x1::vector::empty<u8>(),
            tablero2 : 0x1::vector::empty<u8>(),
            ataques1 : 0x1::vector::empty<u8>(),
            ataques2 : 0x1::vector::empty<u8>(),
            ganador  : @0x0,
        };
        let v2 = 0;
        while (v2 < 100) {
            0x1::vector::push_back<u8>(&mut v1.tablero1, 0);
            0x1::vector::push_back<u8>(&mut v1.tablero2, 0);
            0x1::vector::push_back<u8>(&mut v1.ataques1, 0);
            0x1::vector::push_back<u8>(&mut v1.ataques2, 0);
            v2 = v2 + 1;
        };
        0x2::transfer::share_object<Partida>(v1);
    }

    public fun es_jugador_valido(arg0: &Partida, arg1: address) : bool {
        arg1 == arg0.jugador1 || arg1 == arg0.jugador2
    }

    public fun obtener_estado(arg0: &Partida) : u8 {
        arg0.estado
    }

    public fun obtener_ganador(arg0: &Partida) : address {
        arg0.ganador
    }

    public fun obtener_jugadores(arg0: &Partida) : (address, address) {
        (arg0.jugador1, arg0.jugador2)
    }

    public fun obtener_posicion_ataques(arg0: &Partida, arg1: u64, arg2: &0x2::tx_context::TxContext) : u8 {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(arg1 < 100, 3);
        if (v0 == arg0.jugador1) {
            *0x1::vector::borrow<u8>(&arg0.ataques1, arg1)
        } else {
            assert!(v0 == arg0.jugador2, 5);
            *0x1::vector::borrow<u8>(&arg0.ataques2, arg1)
        }
    }

    public fun obtener_posicion_tablero(arg0: &Partida, arg1: u64, arg2: &0x2::tx_context::TxContext) : u8 {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(arg1 < 100, 3);
        if (v0 == arg0.jugador1) {
            *0x1::vector::borrow<u8>(&arg0.tablero1, arg1)
        } else {
            assert!(v0 == arg0.jugador2, 5);
            *0x1::vector::borrow<u8>(&arg0.tablero2, arg1)
        }
    }

    public fun obtener_turno(arg0: &Partida) : address {
        arg0.turno
    }

    public fun reiniciar_tablero(arg0: &mut Partida, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(arg0.estado == 1, 6);
        let v1 = if (v0 == arg0.jugador1) {
            &mut arg0.tablero1
        } else {
            assert!(v0 == arg0.jugador2, 5);
            &mut arg0.tablero2
        };
        let v2 = 0;
        while (v2 < 100) {
            *0x1::vector::borrow_mut<u8>(v1, v2) = 0;
            v2 = v2 + 1;
        };
    }

    public fun unirse_partida(arg0: &mut Partida, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(arg0.estado == 0, 1);
        assert!(v0 != arg0.jugador1, 5);
        assert!(arg0.jugador2 == @0x0, 9);
        arg0.jugador2 = v0;
        arg0.estado = 1;
    }

    fun verificar_ganador(arg0: &mut Partida) {
        if (contar_barcos_activos(&arg0.tablero1) == 0) {
            arg0.ganador = arg0.jugador2;
            arg0.estado = 2;
        } else if (contar_barcos_activos(&arg0.tablero2) == 0) {
            arg0.ganador = arg0.jugador1;
            arg0.estado = 2;
        };
    }

    // decompiled from Move bytecode v6
}

