module 0x9cbccbf7087e2540ba9c03e14329f449ae47299566dd05b9769f930354a3fc12::suibird {
    struct SUIBIRD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBIRD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBIRD>(arg0, 6, b"SUIBIRD", b"Suibird", b"Suidird on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000097018_a376fd8c05.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBIRD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIBIRD>>(v1);
    }

    // decompiled from Move bytecode v6
}

