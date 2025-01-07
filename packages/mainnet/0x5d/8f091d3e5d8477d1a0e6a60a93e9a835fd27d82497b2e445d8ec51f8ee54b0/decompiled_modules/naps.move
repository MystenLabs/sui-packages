module 0x5d8f091d3e5d8477d1a0e6a60a93e9a835fd27d82497b2e445d8ec51f8ee54b0::naps {
    struct NAPS has drop {
        dummy_field: bool,
    }

    fun init(arg0: NAPS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NAPS>(arg0, 6, b"NAPS", b"SUINAPS", x"4e61707320697320746865206375746573742067686f737420796f75276c6c206d65657420696e204f63746f6265722e200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/00_H_Qgsip_400x400_ccb64f9f55.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NAPS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NAPS>>(v1);
    }

    // decompiled from Move bytecode v6
}

