module 0x62ce817bee9906d6d0b6121c24503e5088c76b5d8aa6d7bd2533c0de188ae034::nana {
    struct NANA has drop {
        dummy_field: bool,
    }

    fun init(arg0: NANA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NANA>(arg0, 6, b"NANA", b"Bananas", x"e2809c576520617265206a757374206172742ee2809d", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731724925376.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NANA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NANA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

