module 0x9a3cc7fcfc8f97a4802ea7c63fa29d0f2ad3012812d4412c3416d76ddcac15c4::suixyz123 {
    struct SUIXYZ123 has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIXYZ123, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIXYZ123>(arg0, 9, b"SUIXYZ123", b"SUIXYZ123", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"ipfs://QmYhZyDyqKp9Dp3k4EsNgq53bYLGdyXU4khGPM8KNGGAQe")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIXYZ123>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIXYZ123>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIXYZ123>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

