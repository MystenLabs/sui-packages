module 0xc12b0d43aabe2f55aa2711de16e18b29c6ae5ce9ce12e931e27a9cf1ec04091a::snoofi {
    struct SNOOFI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNOOFI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNOOFI>(arg0, 6, b"Snoofi", b"Reddit Dog", b"Reddit dog on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000005403_35089ef9cc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNOOFI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SNOOFI>>(v1);
    }

    // decompiled from Move bytecode v6
}

