module 0xc9c864933f806d8e5aabfc9b7fd2e583416648df057b32688d7d45bcbb57aae2::hentai {
    struct HENTAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HENTAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HENTAI>(arg0, 6, b"HENTAI", b"HENTAI COIN", b"HENTAI COIN ON SUI ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5902_ae0fe472c6.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HENTAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HENTAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

