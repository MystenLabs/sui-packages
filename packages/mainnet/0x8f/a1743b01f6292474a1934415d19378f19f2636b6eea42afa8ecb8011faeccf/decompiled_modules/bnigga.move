module 0x8fa1743b01f6292474a1934415d19378f19f2636b6eea42afa8ecb8011faeccf::bnigga {
    struct BNIGGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BNIGGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BNIGGA>(arg0, 6, b"Bnigga", b"Bionicle nigga", b"Bionicle nigga steals your shit and kills you basically", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_9240_41150eca07.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BNIGGA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BNIGGA>>(v1);
    }

    // decompiled from Move bytecode v6
}

