module 0xeb0e479d5b2dac368ca7ebee424dc466d81adcf574d4ea19eda993b2bba57e20::zkpwardensecurity {
    struct Usuario has copy, drop, store {
        direccion: address,
        compromiso: vector<u8>,
        revocado: bool,
    }

    struct Registro has copy, drop, store {
        propietario: address,
        usuarios: vector<Usuario>,
        contador_nonce: u64,
    }

    public fun actualizar_compromiso(arg0: &mut Registro, arg1: address, arg2: vector<u8>) {
        let v0 = encontrar_indice_usuario(&arg0.usuarios, arg1);
        assert!(v0 != 0x1::vector::length<Usuario>(&arg0.usuarios), 2);
        0x1::vector::borrow_mut<Usuario>(&mut arg0.usuarios, v0).compromiso = arg2;
    }

    public fun autenticar(arg0: &Registro, arg1: address, arg2: vector<u8>, arg3: vector<u8>) : bool {
        let v0 = encontrar_indice_usuario(&arg0.usuarios, arg1);
        assert!(v0 != 0x1::vector::length<Usuario>(&arg0.usuarios), 2);
        let v1 = 0x1::vector::borrow<Usuario>(&arg0.usuarios, v0);
        assert!(!v1.revocado, 3);
        verificar_prueba(&v1.compromiso, &arg2, &arg3)
    }

    public fun crear_nonce(arg0: &mut Registro) : vector<u8> {
        let v0 = arg0.contador_nonce;
        arg0.contador_nonce = v0 + 1;
        u64_a_bytes(v0)
    }

    fun encontrar_indice_usuario(arg0: &vector<Usuario>, arg1: address) : u64 {
        let v0 = 0x1::vector::length<Usuario>(arg0);
        let v1 = 0;
        let v2 = v0;
        while (v1 < v0) {
            if (0x1::vector::borrow<Usuario>(arg0, v1).direccion == arg1) {
                v2 = v1;
                break
            };
            v1 = v1 + 1;
        };
        v2
    }

    public fun inicializar_registro(arg0: address) : Registro {
        Registro{
            propietario    : arg0,
            usuarios       : 0x1::vector::empty<Usuario>(),
            contador_nonce : 0,
        }
    }

    public fun obtener_info_usuario(arg0: &Registro, arg1: address) : (vector<u8>, bool) {
        let v0 = encontrar_indice_usuario(&arg0.usuarios, arg1);
        assert!(v0 != 0x1::vector::length<Usuario>(&arg0.usuarios), 2);
        let v1 = 0x1::vector::borrow<Usuario>(&arg0.usuarios, v0);
        (v1.compromiso, v1.revocado)
    }

    public fun registrar_usuario(arg0: &mut Registro, arg1: address, arg2: vector<u8>) {
        assert!(encontrar_indice_usuario(&arg0.usuarios, arg1) == 0x1::vector::length<Usuario>(&arg0.usuarios), 1);
        let v0 = Usuario{
            direccion  : arg1,
            compromiso : arg2,
            revocado   : false,
        };
        0x1::vector::push_back<Usuario>(&mut arg0.usuarios, v0);
    }

    public fun revocar_usuario(arg0: &mut Registro, arg1: address) {
        let v0 = encontrar_indice_usuario(&arg0.usuarios, arg1);
        assert!(v0 != 0x1::vector::length<Usuario>(&arg0.usuarios), 2);
        0x1::vector::borrow_mut<Usuario>(&mut arg0.usuarios, v0).revocado = true;
    }

    public fun simple_hash(arg0: &vector<u8>) : vector<u8> {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<u8>(arg0)) {
            v0 = v0 + (*0x1::vector::borrow<u8>(arg0, v1) as u64);
            v1 = v1 + 1;
        };
        let v2 = 0x1::vector::empty<u8>();
        0x1::vector::push_back<u8>(&mut v2, ((v0 % 256) as u8));
        v2
    }

    fun u64_a_bytes(arg0: u64) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0;
        while (v1 < 8) {
            0x1::vector::push_back<u8>(&mut v0, ((arg0 >> ((v1 * 8) as u8) & 255) as u8));
            v1 = v1 + 1;
        };
        v0
    }

    fun vector_igual(arg0: &vector<u8>, arg1: &vector<u8>) : bool {
        let v0 = 0x1::vector::length<u8>(arg0);
        if (v0 != 0x1::vector::length<u8>(arg1)) {
            return false
        };
        let v1 = 0;
        while (v1 < v0) {
            if (*0x1::vector::borrow<u8>(arg0, v1) != *0x1::vector::borrow<u8>(arg1, v1)) {
                return false
            };
            v1 = v1 + 1;
        };
        true
    }

    public fun verificar_prueba(arg0: &vector<u8>, arg1: &vector<u8>, arg2: &vector<u8>) : bool {
        let v0 = simple_hash(arg1);
        vector_igual(&v0, arg0)
    }

    // decompiled from Move bytecode v6
}

