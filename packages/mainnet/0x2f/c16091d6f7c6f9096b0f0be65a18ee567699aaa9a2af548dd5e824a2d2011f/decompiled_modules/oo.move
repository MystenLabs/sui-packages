module 0x2fc16091d6f7c6f9096b0f0be65a18ee567699aaa9a2af548dd5e824a2d2011f::oo {
    struct OO has drop {
        dummy_field: bool,
    }

    fun init(arg0: OO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OO>(arg0, 9, b"oo", b"oppo", b"o", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<OO>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OO>>(v1);
    }

    // decompiled from Move bytecode v6
}

