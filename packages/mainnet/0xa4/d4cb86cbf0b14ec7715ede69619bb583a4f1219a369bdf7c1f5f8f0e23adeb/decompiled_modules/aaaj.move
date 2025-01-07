module 0xa4d4cb86cbf0b14ec7715ede69619bb583a4f1219a369bdf7c1f5f8f0e23adeb::aaaj {
    struct AAAJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAAJ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAAJ>(arg0, 6, b"AAAJ", b"AaaaJeet Sui", b"aaa im a jeeeeeeet", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241010_103419_85ba83227f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAAJ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAAJ>>(v1);
    }

    // decompiled from Move bytecode v6
}

