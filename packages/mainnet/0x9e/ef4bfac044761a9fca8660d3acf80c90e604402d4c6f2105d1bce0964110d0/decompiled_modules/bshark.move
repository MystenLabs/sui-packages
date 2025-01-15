module 0x9eef4bfac044761a9fca8660d3acf80c90e604402d4c6f2105d1bce0964110d0::bshark {
    struct BSHARK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BSHARK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BSHARK>(arg0, 6, b"BSHARK", b"BullShark", b" Advanced Sniper Bot +  AI Agent +  Dynamic PFP NFTs", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bullshark_a87d1fa92c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BSHARK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BSHARK>>(v1);
    }

    // decompiled from Move bytecode v6
}

