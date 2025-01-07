module 0xadb15ce8730ba33c430009af2bf55c5b856f6d0e4ef83df06bc7cc3efdc4ad78::cheng {
    struct CHENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHENG>(arg0, 6, b"CHENG", b"Cheng SUI CEO", b"The first meme of Evan Cheng SUI'S CEO.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suiceo_57c7e776bc.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

