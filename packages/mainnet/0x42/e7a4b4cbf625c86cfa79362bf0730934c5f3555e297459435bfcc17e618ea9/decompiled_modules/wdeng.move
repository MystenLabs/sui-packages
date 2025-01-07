module 0x42e7a4b4cbf625c86cfa79362bf0730934c5f3555e297459435bfcc17e618ea9::wdeng {
    struct WDENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: WDENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WDENG>(arg0, 6, b"WDeng", b"Wrapped Deng", x"7744454e470a0a4d6f6f44656e67206973207772617070656420616e642068652069732073637265616d696e67206f7574206c6f75642e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000020817_e07fd07683.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WDENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WDENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

