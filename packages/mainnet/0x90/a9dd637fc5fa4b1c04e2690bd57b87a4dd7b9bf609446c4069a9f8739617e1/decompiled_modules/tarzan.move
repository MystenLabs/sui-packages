module 0x90a9dd637fc5fa4b1c04e2690bd57b87a4dd7b9bf609446c4069a9f8739617e1::tarzan {
    struct DenyList has key {
        id: 0x2::object::UID,
        blocked_addresses: vector<address>,
    }

    struct TARZAN has drop {
        dummy_field: bool,
    }

    public entry fun add_to_deny_list(arg0: &mut DenyList, arg1: address, arg2: &0x2::coin::TreasuryCap<TARZAN>) {
        if (!0x1::vector::contains<address>(&arg0.blocked_addresses, &arg1)) {
            0x1::vector::push_back<address>(&mut arg0.blocked_addresses, arg1);
        };
    }

    public entry fun custom_transfer(arg0: 0x2::coin::Coin<TARZAN>, arg1: address, arg2: &DenyList, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!0x1::vector::contains<address>(&arg2.blocked_addresses, &arg1), 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<TARZAN>>(arg0, arg1);
    }

    fun init(arg0: TARZAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TARZAN>(arg0, 9, b"TARZAN", b"Tarzan Token", b"Custom token with deny list", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        let v3 = 0x2::tx_context::sender(arg1);
        0x2::coin::mint_and_transfer<TARZAN>(&mut v2, 1000000000000000000, v3, arg1);
        let v4 = DenyList{
            id                : 0x2::object::new(arg1),
            blocked_addresses : 0x1::vector::empty<address>(),
        };
        0x2::transfer::share_object<DenyList>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TARZAN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TARZAN>>(v2, v3);
    }

    public entry fun remove_from_deny_list(arg0: &mut DenyList, arg1: address, arg2: &0x2::coin::TreasuryCap<TARZAN>) {
        let (v0, v1) = 0x1::vector::index_of<address>(&arg0.blocked_addresses, &arg1);
        if (v0) {
            0x1::vector::remove<address>(&mut arg0.blocked_addresses, v1);
        };
    }

    // decompiled from Move bytecode v6
}

