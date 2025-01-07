module 0x6c0849057abf14099570ca03cd40ea1aea38aab54589b6b8f48aba8c89871df2::suideng {
    struct SUIDENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDENG>(arg0, 6, b"SUIDENG", b"HIPPO", b"A hippopotamus bringing the hype of all chains to the Sui Network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_05_08_10_53_c8c47f4332.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIDENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

