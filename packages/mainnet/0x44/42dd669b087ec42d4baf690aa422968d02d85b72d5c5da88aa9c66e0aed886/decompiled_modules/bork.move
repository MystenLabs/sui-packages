module 0x4442dd669b087ec42d4baf690aa422968d02d85b72d5c5da88aa9c66e0aed886::bork {
    struct BORK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BORK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BORK>(arg0, 6, b"BORK", b"Bob Fork", b"Bob Fork on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_19_20_14_15_ec2617bb05.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BORK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BORK>>(v1);
    }

    // decompiled from Move bytecode v6
}

