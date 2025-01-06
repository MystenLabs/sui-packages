module 0x8f772a64ed90bfcc0da9cfcf828c42afd6bede1cdba4a566ad84ea4bee72b57c::coge {
    struct COGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: COGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COGE>(arg0, 6, b"COGE", b"Coge", b"COGE is an innovative memecoin designed specifically for the SUI blockchain ecosystem. Inspired by the charm and humor of internet meme culture, COGE blends entertainment, community, and earning potential through blockchain technology.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20250106_024224_02e02647f4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<COGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

