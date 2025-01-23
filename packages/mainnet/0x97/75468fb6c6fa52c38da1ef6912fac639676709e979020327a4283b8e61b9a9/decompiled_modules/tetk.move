module 0x9775468fb6c6fa52c38da1ef6912fac639676709e979020327a4283b8e61b9a9::tetk {
    struct TETK has drop {
        dummy_field: bool,
    }

    fun init(arg0: TETK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TETK>(arg0, 4, b"TETK", b"Test token", b"Test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://public-cdn.daossui.io/assets/tokens/0ff81570-d95c-11ef-a74b-b3b817eed47e")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TETK>>(v1);
        0x2::coin::mint_and_transfer<TETK>(&mut v2, 11000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TETK>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

