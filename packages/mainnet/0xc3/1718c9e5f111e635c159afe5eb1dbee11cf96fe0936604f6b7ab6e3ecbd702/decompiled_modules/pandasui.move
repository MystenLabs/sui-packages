module 0xc31718c9e5f111e635c159afe5eb1dbee11cf96fe0936604f6b7ab6e3ecbd702::pandasui {
    struct PANDASUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PANDASUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PANDASUI>(arg0, 6, b"PANDASUI", b"First Panda On Sui", b"First Panda On Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logo_3_2cbcc961f6.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PANDASUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PANDASUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

