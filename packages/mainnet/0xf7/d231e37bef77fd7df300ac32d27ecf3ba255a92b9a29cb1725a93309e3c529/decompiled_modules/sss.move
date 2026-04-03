module 0xf7d231e37bef77fd7df300ac32d27ecf3ba255a92b9a29cb1725a93309e3c529::sss {
    struct SSS has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<SSS>, arg1: 0x2::coin::Coin<SSS>) {
        0x2::coin::burn<SSS>(arg0, arg1);
    }

    fun init(arg0: SSS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSS>(arg0, 9, b"SSS", b"SSS", b"Custom SUI Token: SSS", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SSS>(&mut v2, 10000000000000, 0x2::tx_context::sender(arg1), arg1);
        let v3 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSS>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SSS>>(v1);
    }

    // decompiled from Move bytecode v7
}

