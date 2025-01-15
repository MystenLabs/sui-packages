module 0xdcc4d7c5f0f16c27bda30111997466ce1442b56653e1ca4024047caa46f120a::bshark {
    struct BSHARK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BSHARK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BSHARK>(arg0, 6, b"BSHARK", b"BULLSHARK", b"Meet the fastest creature in the sea Advanced Sniper Bot +  AI Agent +  Dynamic PFP NFTs", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bullshark_e7b397d024.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BSHARK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BSHARK>>(v1);
    }

    // decompiled from Move bytecode v6
}

