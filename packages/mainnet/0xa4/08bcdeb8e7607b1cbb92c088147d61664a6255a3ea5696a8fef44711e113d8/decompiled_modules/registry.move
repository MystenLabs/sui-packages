module 0xa408bcdeb8e7607b1cbb92c088147d61664a6255a3ea5696a8fef44711e113d8::registry {
    struct SignerRegistry has key {
        id: 0x2::object::UID,
        signer_pubkey: vector<u8>,
        paused: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct SignerSet has copy, drop {
        public_key: vector<u8>,
    }

    struct PauseSet has copy, drop {
        paused: bool,
    }

    fun assert_valid_pubkey(arg0: &vector<u8>) {
        assert!(0x1::vector::length<u8>(arg0) == 33, 1);
        let v0 = *0x1::vector::borrow<u8>(arg0, 0);
        assert!(v0 == 2 || v0 == 3, 2);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = SignerRegistry{
            id            : 0x2::object::new(arg0),
            signer_pubkey : b"",
            paused        : false,
        };
        0x2::transfer::share_object<SignerRegistry>(v1);
    }

    public fun is_paused(arg0: &SignerRegistry) : bool {
        arg0.paused
    }

    public fun set_paused(arg0: &mut SignerRegistry, arg1: &AdminCap, arg2: bool) {
        arg0.paused = arg2;
        let v0 = PauseSet{paused: arg2};
        0x2::event::emit<PauseSet>(v0);
    }

    public fun set_signer(arg0: &mut SignerRegistry, arg1: &AdminCap, arg2: vector<u8>) {
        assert_valid_pubkey(&arg2);
        arg0.signer_pubkey = arg2;
        let v0 = SignerSet{public_key: arg2};
        0x2::event::emit<SignerSet>(v0);
    }

    public fun signer_pubkey(arg0: &SignerRegistry) : vector<u8> {
        arg0.signer_pubkey
    }

    // decompiled from Move bytecode v7
}

