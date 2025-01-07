module 0xa9dfcd83b99989b1c2e4ddefaee455ed9b8d90166ddbd57492eeac852df4b35f::carter {
    struct CARTER has drop {
        dummy_field: bool,
    }

    fun init(arg0: CARTER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CARTER>(arg0, 6, b"CARTER", b"Carter Wyatt", b"Hi! I'm Carter. an experienced full-time freelance graphic designer specialising in logos, branding, brand identity, cartoon logos, retro illustrations, comics, NFTs, meme coin art, mascots, doodles and cartoon characters. With years of experience, We work together to give your illustrations a unique and lasting presence. I will always do my best. This will often ensure a better experience. Thank you!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000048535_1edb27a1aa.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CARTER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CARTER>>(v1);
    }

    // decompiled from Move bytecode v6
}

