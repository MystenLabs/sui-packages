module 0xa46d35c9e5fb7ce0c54a94b38de6a695111ff6d44dcf59413f1359c5b39b1c8d::bows {
    struct BOWS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOWS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOWS>(arg0, 6, b"BOWS", b"Book of Wall Street Sui", b"Inspired by the legendary world of Wall Street", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logo_32_306347c1a8.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOWS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOWS>>(v1);
    }

    // decompiled from Move bytecode v6
}

