module 0x92af25ec686ee92faecfa3ae54fd2505387a8b4e60c8a02db1e0462c5b2cb0e8::niggachu {
    struct NIGGACHU has drop {
        dummy_field: bool,
    }

    fun init(arg0: NIGGACHU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NIGGACHU>(arg0, 6, b"NIGGACHU", b"Nigga Chu", b"Nigga Niga!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/niga_3620cfcf7d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NIGGACHU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NIGGACHU>>(v1);
    }

    // decompiled from Move bytecode v6
}

