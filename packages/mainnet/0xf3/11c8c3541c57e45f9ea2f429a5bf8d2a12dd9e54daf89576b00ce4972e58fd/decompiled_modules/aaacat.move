module 0xf311c8c3541c57e45f9ea2f429a5bf8d2a12dd9e54daf89576b00ce4972e58fd::aaacat {
    struct AAACAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAACAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAACAT>(arg0, 6, b"Aaacat", b"Aaa Cat ", b"Aaaaaaaaaaaaaaaa cat ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731177320617.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AAACAT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAACAT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

