module 0x42d3270fde9330380fbc715007c9e5e57b54661da7a088ac31f17106be71f4c::suixyz12 {
    struct SUIXYZ12 has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIXYZ12, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIXYZ12>(arg0, 9, b"SUIXYZ12", b"SUIXYZ12", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"ipfs://QmYhZyDyqKp9Dp3k4EsNgq53bYLGdyXU4khGPM8KNGGAQe")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIXYZ12>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIXYZ12>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIXYZ12>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

