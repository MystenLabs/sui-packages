module 0x7341f7c09e9571f5309a501d453e8b5ffe9867af417cbe38476d1ec0923ee8ed::aqm {
    struct AQM has drop {
        dummy_field: bool,
    }

    fun init(arg0: AQM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AQM>(arg0, 6, b"AQM", b"AQUAMAN", b"This token meme SUPERHERO of AQUA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GZXE_Jzp_XAAAFC_Ai_62c3203c98.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AQM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AQM>>(v1);
    }

    // decompiled from Move bytecode v6
}

