module 0x2ce3a8b3110e69550ccf764721c9c61f8d3be7f3f34d85d1a69152a2c2151fd8::tarzan {
    struct MemberRegistry has key {
        id: 0x2::object::UID,
        restricted_addresses: vector<address>,
    }

    struct TARZAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: TARZAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TARZAN>(arg0, 9, b"TARZAN", b"Tarzan Token", b"Token with member-only transfers", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        let v3 = 0x2::tx_context::sender(arg1);
        0x2::coin::mint_and_transfer<TARZAN>(&mut v2, 1000000000000000000, v3, arg1);
        let v4 = MemberRegistry{
            id                   : 0x2::object::new(arg1),
            restricted_addresses : 0x1::vector::empty<address>(),
        };
        0x2::transfer::share_object<MemberRegistry>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TARZAN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TARZAN>>(v2, v3);
    }

    public entry fun member_transfer(arg0: 0x2::coin::Coin<TARZAN>, arg1: address, arg2: &MemberRegistry, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!0x1::vector::contains<address>(&arg2.restricted_addresses, &arg1), 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<TARZAN>>(arg0, arg1);
    }

    public entry fun restrict_member(arg0: &mut MemberRegistry, arg1: address, arg2: &0x2::coin::TreasuryCap<TARZAN>) {
        let v0 = &mut arg0.restricted_addresses;
        if (!0x1::vector::contains<address>(v0, &arg1)) {
            0x1::vector::push_back<address>(v0, arg1);
        };
    }

    public entry fun unrestrict_member(arg0: &mut MemberRegistry, arg1: address, arg2: &0x2::coin::TreasuryCap<TARZAN>) {
        let v0 = &mut arg0.restricted_addresses;
        let (v1, v2) = 0x1::vector::index_of<address>(v0, &arg1);
        if (v1) {
            0x1::vector::remove<address>(v0, v2);
        };
    }

    // decompiled from Move bytecode v6
}

