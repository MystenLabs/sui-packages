module 0x2db671f39bab962969aa918edf0bb6dc53035dd890730071d9e9440bbf2a3776::tfrog {
    struct TFROG has drop {
        dummy_field: bool,
    }

    fun init(arg0: TFROG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TFROG>(arg0, 6, b"Tfrog", b"TFrog", b"Just Testing", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20240102_202838_b71e0ef84b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TFROG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TFROG>>(v1);
    }

    // decompiled from Move bytecode v6
}

