module 0xf2758fb17ed18f2b7b447c356ba77493333df996f945c30be64a359551e8faea::lish {
    struct LISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: LISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LISH>(arg0, 6, b"LISH", b"SUI BULL SEASON", b"Bull season is upon us. No TG, X and Web links coming. Just buy and HODL", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_2680_3a949bb003.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

