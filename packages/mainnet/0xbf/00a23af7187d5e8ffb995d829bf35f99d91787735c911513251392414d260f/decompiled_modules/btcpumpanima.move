module 0xbf00a23af7187d5e8ffb995d829bf35f99d91787735c911513251392414d260f::btcpumpanima {
    struct BTCPUMPANIMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BTCPUMPANIMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BTCPUMPANIMA>(arg0, 6, b"BTCPUMPANIMA", b"BTCPUMPANIMAL", b"BTC PUUMP", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/eplhant_8e2686c648.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BTCPUMPANIMA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BTCPUMPANIMA>>(v1);
    }

    // decompiled from Move bytecode v6
}

