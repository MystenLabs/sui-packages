module 0x44458075d28ce1c40ab2c242fd536f498d918f23620d74b81971ad2e113b76f0::suiman {
    struct SUIMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMAN>(arg0, 6, b"SUIMAN", b"SUIPPOMAN", b"Sui welcomes Suppoman. Biggest influencer on Sui. Time to give back. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://movepump.xyz/uploads/IMG_1613_06b5569b35.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

