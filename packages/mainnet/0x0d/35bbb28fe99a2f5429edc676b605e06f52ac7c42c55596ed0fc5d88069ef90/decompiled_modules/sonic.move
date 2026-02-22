module 0xd35bbb28fe99a2f5429edc676b605e06f52ac7c42c55596ed0fc5d88069ef90::sonic {
    struct SONIC has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<SONIC>, arg1: 0x2::coin::Coin<SONIC>) {
        0x2::coin::burn<SONIC>(arg0, arg1);
    }

    fun init(arg0: SONIC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SONIC>(arg0, 9, b"SONIC", b"SONIC", b"Custom SUI Token: SONIC", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SONIC>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        let v3 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SONIC>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SONIC>>(v1);
    }

    public fun mint(arg0: &AdminCap, arg1: &mut 0x2::coin::TreasuryCap<SONIC>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SONIC>(arg1, arg2, arg3, arg4);
    }

    // decompiled from Move bytecode v6
}

