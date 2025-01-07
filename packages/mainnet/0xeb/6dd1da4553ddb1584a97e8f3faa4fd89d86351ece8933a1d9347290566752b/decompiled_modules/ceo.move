module 0xeb6dd1da4553ddb1584a97e8f3faa4fd89d86351ece8933a1d9347290566752b::ceo {
    struct CEO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CEO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CEO>(arg0, 6, b"CEO", b"Cheng Paul NEW CEO", b"Cheng Paul is the NEW CEO of SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Capture_da_A_cran_2024_10_10_175418_fd149b64dc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CEO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CEO>>(v1);
    }

    // decompiled from Move bytecode v6
}

