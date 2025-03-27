module 0xee98c88f027f36b2d30c55f8c4f84bdc512f1ee52d978907c28a53caba2a3f89::bwal {
    struct BWAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BWAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BWAL>(arg0, 6, b"BWAL", b"Baby Walrus", b"BWAL may stand out due to its strong community support, a key factor in the growth of meme coins. If the project has a smart marketing strategy, such as leveraging social media like X to spread the message, or collaborating with influencers (KOLs), that is also a notable point. At this point, if BWAL is in the presale phase or has just launched, it may be generating excitement due to the opportunity to invest early at a low price, attracting investors looking for high returns in the short term.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2025_03_27_21_44_37_f23ef5c4c7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BWAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BWAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

