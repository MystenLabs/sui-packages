module 0x9d14583975011145cd0b75a85bd4c44d375d8b39f99c3bdc4a9190a34f84853c::archieve {
    struct ARCHIEVE has drop {
        dummy_field: bool,
    }

    struct Archieve<phantom T0> has key {
        id: 0x2::object::UID,
        peg_nonce: u128,
        depeg_nonce: u128,
    }

    struct UserReg has store, key {
        id: 0x2::object::UID,
    }

    struct ArchieveFlag<phantom T0> has copy, drop, store {
        owner: address,
    }

    public fun increaseGetDepegNonce<T0>(arg0: &mut Archieve<T0>) : u128 {
        arg0.depeg_nonce = arg0.depeg_nonce + 1;
        arg0.depeg_nonce
    }

    fun init(arg0: ARCHIEVE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = UserReg{id: 0x2::object::new(arg1)};
        0x2::transfer::public_share_object<UserReg>(v0);
    }

    public fun registerArch<T0>(arg0: &mut UserReg, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = ArchieveFlag<T0>{owner: v0};
        assert!(!0x2::dynamic_field::exists_<ArchieveFlag<T0>>(&arg0.id, v1), 8003);
        let v2 = Archieve<T0>{
            id          : 0x2::object::new(arg1),
            peg_nonce   : 0,
            depeg_nonce : 0,
        };
        0x2::transfer::transfer<Archieve<T0>>(v2, v0);
        0x2::dynamic_field::add<ArchieveFlag<T0>, bool>(&mut arg0.id, v1, true);
    }

    public fun verUpdateDepegNonce<T0>(arg0: u128, arg1: &mut Archieve<T0>) {
        assert!(arg1.depeg_nonce < arg0, 8002);
        arg1.depeg_nonce = arg0;
    }

    public fun verUpdatePegNonce<T0>(arg0: u128, arg1: &mut Archieve<T0>) {
        assert!(arg1.peg_nonce < arg0, 8002);
        arg1.peg_nonce = arg0;
    }

    public fun verifySignature(arg0: vector<u8>, arg1: vector<u8>, arg2: &0x1::option::Option<vector<u8>>) {
        assert!(0x1::option::is_some<vector<u8>>(arg2), 8001);
        assert!(0x2::ed25519::ed25519_verify(&arg0, 0x1::option::borrow<vector<u8>>(arg2), &arg1), 8000);
    }

    // decompiled from Move bytecode v6
}

