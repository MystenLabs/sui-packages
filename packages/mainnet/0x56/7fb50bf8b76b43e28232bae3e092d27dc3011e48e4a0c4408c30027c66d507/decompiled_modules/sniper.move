module 0x567fb50bf8b76b43e28232bae3e092d27dc3011e48e4a0c4408c30027c66d507::sniper {
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

    fun monitor_contracts() {
    }

    public entry fun toggle_active(arg0: &mut Sniper, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner_address, 1);
        arg0.is_active = !arg0.is_active;
    }

    public entry fun withdraw_funds(arg0: &mut Sniper, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

