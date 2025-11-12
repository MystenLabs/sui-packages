module 0xb0710c9af9df01ebbcbb61d654d82119c100ee0d507c939342968219026239b1::acuario_virtual {
    struct Acuario has key {
        id: 0x2::object::UID,
        propietario: address,
        nombre: 0x1::string::String,
        capacidad_maxima: u64,
        peces: 0x2::table::Table<0x2::object::ID, Pez>,
        num_peces: u64,
        calidad_agua: u64,
        temperatura: u64,
        nivel_oxigeno: u64,
        ultima_limpieza: u64,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        nivel: u64,
        experiencia: u64,
    }

    struct Pez has store, key {
        id: 0x2::object::UID,
        especie: 0x1::string::String,
        nombre: 0x1::string::String,
        nivel_salud: u64,
        nivel_hambre: u64,
        edad: u64,
        nacimiento: u64,
        rareza: u64,
        esta_vivo: bool,
    }

    struct ConfiguracionEspecie has key {
        id: 0x2::object::UID,
        especies: 0x2::table::Table<0x1::string::String, DatosEspecie>,
    }

    struct DatosEspecie has store {
        nombre: 0x1::string::String,
        temperatura_min: u64,
        temperatura_max: u64,
        costo: u64,
        rareza: u64,
    }

    public fun actualizar_estado(arg0: &mut Acuario, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.propietario == 0x2::tx_context::sender(arg2), 1);
        let v0 = (0x2::clock::timestamp_ms(arg1) - arg0.ultima_limpieza) / 3600000 * 5;
        if (arg0.calidad_agua > v0) {
            arg0.calidad_agua = arg0.calidad_agua - v0;
        } else {
            arg0.calidad_agua = 0;
        };
        if (arg0.nivel_oxigeno > 10) {
            arg0.nivel_oxigeno = arg0.nivel_oxigeno - 10;
        } else {
            arg0.nivel_oxigeno = 0;
        };
    }

    public fun agregar_pez(arg0: &mut Acuario, arg1: vector<u8>, arg2: vector<u8>, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.propietario == 0x2::tx_context::sender(arg5), 1);
        assert!(arg0.num_peces < arg0.capacidad_maxima, 2);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) >= 500000, 4);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg3));
        let v0 = Pez{
            id           : 0x2::object::new(arg5),
            especie      : 0x1::string::utf8(arg1),
            nombre       : 0x1::string::utf8(arg2),
            nivel_salud  : 100,
            nivel_hambre : 0,
            edad         : 0,
            nacimiento   : 0x2::clock::timestamp_ms(arg4),
            rareza       : 1,
            esta_vivo    : true,
        };
        0x2::table::add<0x2::object::ID, Pez>(&mut arg0.peces, 0x2::object::id<Pez>(&v0), v0);
        arg0.num_peces = arg0.num_peces + 1;
        arg0.experiencia = arg0.experiencia + 10;
    }

    public fun ajustar_temperatura(arg0: &mut Acuario, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.propietario == 0x2::tx_context::sender(arg2), 1);
        assert!(arg1 >= 18 && arg1 <= 30, 5);
        arg0.temperatura = arg1;
        arg0.experiencia = arg0.experiencia + 5;
    }

    public fun alimentar_pez(arg0: &mut Acuario, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.propietario == 0x2::tx_context::sender(arg2), 1);
        assert!(0x2::table::contains<0x2::object::ID, Pez>(&arg0.peces, arg1), 3);
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, Pez>(&mut arg0.peces, arg1);
        assert!(v0.esta_vivo, 6);
        if (v0.nivel_hambre > 20) {
            v0.nivel_hambre = v0.nivel_hambre - 20;
        } else {
            v0.nivel_hambre = 0;
        };
        if (v0.nivel_salud < 100) {
            v0.nivel_salud = v0.nivel_salud + 5;
            if (v0.nivel_salud > 100) {
                v0.nivel_salud = 100;
            };
        };
        arg0.experiencia = arg0.experiencia + 2;
    }

    public fun crear_acuario(arg0: vector<u8>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = Acuario{
            id               : 0x2::object::new(arg3),
            propietario      : 0x2::tx_context::sender(arg3),
            nombre           : 0x1::string::utf8(arg0),
            capacidad_maxima : arg1,
            peces            : 0x2::table::new<0x2::object::ID, Pez>(arg3),
            num_peces        : 0,
            calidad_agua     : 100,
            temperatura      : 24,
            nivel_oxigeno    : 100,
            ultima_limpieza  : 0x2::clock::timestamp_ms(arg2),
            balance          : 0x2::balance::zero<0x2::sui::SUI>(),
            nivel            : 1,
            experiencia      : 0,
        };
        0x2::transfer::transfer<Acuario>(v0, 0x2::tx_context::sender(arg3));
    }

    public fun expandir_capacidad(arg0: &mut Acuario, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.propietario == 0x2::tx_context::sender(arg2), 1);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= arg0.capacidad_maxima * 1000000, 4);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        arg0.capacidad_maxima = arg0.capacidad_maxima + 5;
        arg0.experiencia = arg0.experiencia + 50;
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ConfiguracionEspecie{
            id       : 0x2::object::new(arg0),
            especies : 0x2::table::new<0x1::string::String, DatosEspecie>(arg0),
        };
        0x2::transfer::share_object<ConfiguracionEspecie>(v0);
    }

    public fun limpiar_acuario(arg0: &mut Acuario, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.propietario == 0x2::tx_context::sender(arg3), 1);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= 100000, 4);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        arg0.calidad_agua = 100;
        arg0.nivel_oxigeno = 100;
        arg0.ultima_limpieza = 0x2::clock::timestamp_ms(arg2);
        arg0.experiencia = arg0.experiencia + 15;
        if (arg0.experiencia >= arg0.nivel * 100) {
            arg0.nivel = arg0.nivel + 1;
        };
    }

    public fun obtener_info_acuario(arg0: &Acuario) : (u64, u64, u64, u64, u64, u64) {
        (arg0.num_peces, arg0.capacidad_maxima, arg0.calidad_agua, arg0.temperatura, arg0.nivel_oxigeno, arg0.nivel)
    }

    public fun obtener_info_pez(arg0: &Pez) : (u64, u64, u64, bool) {
        (arg0.nivel_salud, arg0.nivel_hambre, arg0.edad, arg0.esta_vivo)
    }

    public fun oxigenar_agua(arg0: &mut Acuario, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.propietario == 0x2::tx_context::sender(arg1), 1);
        if (arg0.nivel_oxigeno < 100) {
            arg0.nivel_oxigeno = arg0.nivel_oxigeno + 20;
            if (arg0.nivel_oxigeno > 100) {
                arg0.nivel_oxigeno = 100;
            };
        };
        arg0.experiencia = arg0.experiencia + 3;
    }

    public fun retirar_pez(arg0: &mut Acuario, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.propietario == 0x2::tx_context::sender(arg2), 1);
        assert!(0x2::table::contains<0x2::object::ID, Pez>(&arg0.peces, arg1), 3);
        arg0.num_peces = arg0.num_peces - 1;
        0x2::transfer::public_transfer<Pez>(0x2::table::remove<0x2::object::ID, Pez>(&mut arg0.peces, arg1), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

