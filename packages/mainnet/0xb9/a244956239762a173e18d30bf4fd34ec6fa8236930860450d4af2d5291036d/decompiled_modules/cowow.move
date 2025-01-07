module 0xb9a244956239762a173e18d30bf4fd34ec6fa8236930860450d4af2d5291036d::cowow {
    struct COWOW has drop {
        dummy_field: bool,
    }

    fun init(arg0: COWOW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COWOW>(arg0, 9, b"COWOW", b"ANGRY COW", b"ANGRY COWWW", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<COWOW>(&mut v2, 24000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COWOW>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<COWOW>>(v1);
    }

    // decompiled from Move bytecode v6
}

