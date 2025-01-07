module 0xc059c349a29ae683b4d21b1247f501840608be50834e093f6fea784ce9989792::blunana {
    struct BLUNANA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUNANA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUNANA>(arg0, 6, b"Blunana", b"Blunana Suinana", b"Banana Blue? Yes Sir!! Think Different, this is Suinana", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/LOGO_BLUN_3f4447e7ae.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUNANA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUNANA>>(v1);
    }

    // decompiled from Move bytecode v6
}

