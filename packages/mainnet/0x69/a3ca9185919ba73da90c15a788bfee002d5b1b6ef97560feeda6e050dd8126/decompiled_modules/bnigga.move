module 0x69a3ca9185919ba73da90c15a788bfee002d5b1b6ef97560feeda6e050dd8126::bnigga {
    struct BNIGGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BNIGGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BNIGGA>(arg0, 6, b"BNIGGA", b"Bionicle Nigga", b"Bionicle nigga steals your shit and kills you basically ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_9240_2607239531.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BNIGGA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BNIGGA>>(v1);
    }

    // decompiled from Move bytecode v6
}

