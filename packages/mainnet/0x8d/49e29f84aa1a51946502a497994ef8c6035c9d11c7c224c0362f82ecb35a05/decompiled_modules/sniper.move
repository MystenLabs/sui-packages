module 0x8d49e29f84aa1a51946502a497994ef8c6035c9d11c7c224c0362f82ecb35a05::sniper {
    struct Sniper has store, key {
        id: 0x2::object::UID,
        owner_address: address,
        is_active: bool,
    }

    public entry fun init_sniper(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = internal_init(arg0);
        0x2::transfer::transfer<Sniper>(v0, 0x2::tx_context::sender(arg0));
    }

    fun internal_init(arg0: &mut 0x2::tx_context::TxContext) : Sniper {
        Sniper{
            id            : 0x2::object::new(arg0),
            owner_address : 0x2::tx_context::sender(arg0),
            is_active     : false,
        }
    }

    public entry fun toggle_active(arg0: &mut Sniper, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner_address, 1);
        arg0.is_active = !arg0.is_active;
    }

    // decompiled from Move bytecode v6
}

