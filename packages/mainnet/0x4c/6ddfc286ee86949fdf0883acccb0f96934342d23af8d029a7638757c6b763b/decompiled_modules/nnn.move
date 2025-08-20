module 0x4c6ddfc286ee86949fdf0883acccb0f96934342d23af8d029a7638757c6b763b::nnn {
    struct NNN has drop {
        dummy_field: bool,
    }

    fun init(arg0: NNN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NNN>(arg0, 9, b"NNN", b"200%NGR", b"dwqsdqwadwqeqwewqewqe", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<NNN>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NNN>>(v2, @0xde54a2563797ee480fa49320d104051a158973abef8d516e8f9b5701636a2ca7);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NNN>>(v1);
    }

    // decompiled from Move bytecode v6
}

