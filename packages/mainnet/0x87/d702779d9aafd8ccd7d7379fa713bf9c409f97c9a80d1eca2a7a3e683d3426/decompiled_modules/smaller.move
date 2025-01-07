module 0x87d702779d9aafd8ccd7d7379fa713bf9c409f97c9a80d1eca2a7a3e683d3426::smaller {
    struct SMALLER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMALLER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMALLER>(arg0, 6, b"Smaller", b"smaller AI models", b"I've been thinking a lot about what this could look like. I think it would involve a large, interconnected network of smaller AI models that are tuned to different topologies of thought", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/AQI_Upf_L3_400x400_d89563515a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMALLER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMALLER>>(v1);
    }

    // decompiled from Move bytecode v6
}

