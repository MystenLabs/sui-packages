module 0x14eefbc0a6da66e9bd7d4cc6e95fb0735cd40a14b2743eb62339a3ba061bbd5d::goga {
    struct GOGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOGA>(arg0, 9, b"GOGA", b"GOGA", b"GOGA COIN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GOGA>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOGA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOGA>>(v1);
    }

    // decompiled from Move bytecode v6
}

