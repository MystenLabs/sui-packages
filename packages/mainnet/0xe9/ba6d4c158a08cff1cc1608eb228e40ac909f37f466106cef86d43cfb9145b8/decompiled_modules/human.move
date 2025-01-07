module 0xe9ba6d4c158a08cff1cc1608eb228e40ac909f37f466106cef86d43cfb9145b8::human {
    struct HUMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: HUMAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HUMAN>(arg0, 6, b"HUMAN", b"HUMAN SUI", b"101 NFT HUMAN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_6520_c5adbaef22.JPG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HUMAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HUMAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

