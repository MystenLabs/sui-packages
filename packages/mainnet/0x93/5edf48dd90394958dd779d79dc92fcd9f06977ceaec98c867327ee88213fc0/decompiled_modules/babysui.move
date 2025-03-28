module 0x935edf48dd90394958dd779d79dc92fcd9f06977ceaec98c867327ee88213fc0::babysui {
    struct BABYSUI has drop {
        dummy_field: bool,
    }

    struct AirdropPool has store, key {
        id: 0x2::object::UID,
        whitelist: 0x2::table::Table<address, u64>,
        whitelist_amount: u64,
        owner: address,
    }

    struct Treasury<phantom T0> has key {
        id: 0x2::object::UID,
        token: 0x2::balance::Balance<T0>,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<BABYSUI>, arg1: 0x2::coin::Coin<BABYSUI>) {
        0x2::coin::burn<BABYSUI>(arg0, arg1);
    }

    public entry fun add_a_whitelist(arg0: &mut AirdropPool, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 3);
        if (!0x2::table::contains<address, u64>(&arg0.whitelist, arg1)) {
            0x2::table::add<address, u64>(&mut arg0.whitelist, arg1, 0);
        };
    }

    public entry fun add_whitelist(arg0: &mut AirdropPool, arg1: vector<address>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 3);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg1)) {
            if (!0x2::table::contains<address, u64>(&arg0.whitelist, *0x1::vector::borrow<address>(&arg1, v0))) {
                0x2::table::add<address, u64>(&mut arg0.whitelist, *0x1::vector::borrow<address>(&arg1, v0), 0);
            };
            v0 = v0 + 1;
        };
    }

    public entry fun claim<T0>(arg0: &mut AirdropPool, arg1: &mut Treasury<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = arg0.whitelist_amount;
        assert!(0x2::table::contains<address, u64>(&arg0.whitelist, v0), 1);
        assert!(*0x2::table::borrow<address, u64>(&arg0.whitelist, v0) < v1, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg1.token, v1, arg2), v0);
        *0x2::table::borrow_mut<address, u64>(&mut arg0.whitelist, v0) = v1;
    }

    public entry fun create_treasury<T0>(arg0: &mut AirdropPool, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 3);
        let v0 = Treasury<T0>{
            id    : 0x2::object::new(arg2),
            token : 0x2::coin::into_balance<T0>(arg1),
        };
        0x2::transfer::share_object<Treasury<T0>>(v0);
    }

    public entry fun deposit_to_pool<T0>(arg0: &mut AirdropPool, arg1: 0x2::coin::Coin<T0>, arg2: &mut Treasury<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg3), 3);
        0x2::balance::join<T0>(&mut arg2.token, 0x2::coin::into_balance<T0>(arg1));
    }

    fun init(arg0: BABYSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYSUI>(arg0, 2, b"BABYSUI", b"Babysui", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BABYSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYSUI>>(v0, 0x2::tx_context::sender(arg1));
        let v2 = AirdropPool{
            id               : 0x2::object::new(arg1),
            whitelist        : 0x2::table::new<address, u64>(arg1),
            whitelist_amount : 0,
            owner            : 0x2::tx_context::sender(arg1),
        };
        0x2::transfer::share_object<AirdropPool>(v2);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<BABYSUI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<BABYSUI>(arg0, arg1, arg2, arg3);
    }

    public entry fun remove_a_whitelist(arg0: &mut AirdropPool, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 3);
        if (0x2::table::contains<address, u64>(&arg0.whitelist, arg1)) {
            0x2::table::remove<address, u64>(&mut arg0.whitelist, arg1);
        };
    }

    public entry fun remove_whitelist(arg0: &mut AirdropPool, arg1: vector<address>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 3);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg1)) {
            if (0x2::table::contains<address, u64>(&arg0.whitelist, *0x1::vector::borrow<address>(&arg1, v0))) {
                0x2::table::remove<address, u64>(&mut arg0.whitelist, *0x1::vector::borrow<address>(&arg1, v0));
            };
            v0 = v0 + 1;
        };
    }

    public entry fun set_airdrop_amount(arg0: &mut AirdropPool, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 3);
        arg0.whitelist_amount = arg1;
    }

    public entry fun transferOwnership(arg0: 0x2::coin::TreasuryCap<BABYSUI>, arg1: address, arg2: &mut AirdropPool, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(arg2.owner == v0, 3);
        arg2.owner = v0;
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYSUI>>(arg0, arg1);
    }

    public entry fun withdraw<T0>(arg0: &mut AirdropPool, arg1: u64, arg2: address, arg3: &mut Treasury<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg4), 3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg3.token, arg1, arg4), arg2);
    }

    // decompiled from Move bytecode v6
}

