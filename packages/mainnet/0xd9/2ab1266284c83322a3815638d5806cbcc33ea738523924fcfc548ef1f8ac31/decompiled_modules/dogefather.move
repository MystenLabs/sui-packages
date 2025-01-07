module 0xd92ab1266284c83322a3815638d5806cbcc33ea738523924fcfc548ef1f8ac31::dogefather {
    struct DOGEFATHER has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGEFATHER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGEFATHER>(arg0, 6, b"Dogefather", b"The Dogefather", b"https://x.com/elonmusk/status/1839195677710008417", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/dogefather_ca17d05f8d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGEFATHER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGEFATHER>>(v1);
    }

    // decompiled from Move bytecode v6
}

