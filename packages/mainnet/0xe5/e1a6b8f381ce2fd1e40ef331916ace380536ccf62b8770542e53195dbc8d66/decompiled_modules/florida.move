module 0xe5e1a6b8f381ce2fd1e40ef331916ace380536ccf62b8770542e53195dbc8d66::florida {
    struct FLORIDA has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLORIDA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLORIDA>(arg0, 9, b"Florida", b"Florida", b"Florida USA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FLORIDA>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLORIDA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FLORIDA>>(v1);
    }

    // decompiled from Move bytecode v6
}

