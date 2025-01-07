module 0xeee79fa52a98c08020ca7785dcd90772fb1a74e1b305ed9abde3b46233e3ca78::amber {
    struct AMBER has drop {
        dummy_field: bool,
    }

    fun init(arg0: AMBER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AMBER>(arg0, 6, b"AMBER", b"Amber Baldet", b"A meme coin for Amber Baldet, co-founder of Clovyr and a blockchain leader.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Amber_Baldet_Coin_06318be7a8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AMBER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AMBER>>(v1);
    }

    // decompiled from Move bytecode v6
}

