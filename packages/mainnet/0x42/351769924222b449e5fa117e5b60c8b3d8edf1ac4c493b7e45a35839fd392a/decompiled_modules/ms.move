module 0x42351769924222b449e5fa117e5b60c8b3d8edf1ac4c493b7e45a35839fd392a::ms {
    struct MS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MS>(arg0, 6, b"MS", b"MEOWSSUI", b"MEOWSSSSSUIIIIIIIIIIII", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/seee_c072505d2c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MS>>(v1);
    }

    // decompiled from Move bytecode v6
}

