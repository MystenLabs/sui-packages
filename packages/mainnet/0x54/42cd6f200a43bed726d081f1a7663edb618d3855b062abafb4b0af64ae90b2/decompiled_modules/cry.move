module 0x5442cd6f200a43bed726d081f1a7663edb618d3855b062abafb4b0af64ae90b2::cry {
    struct CRY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRY>(arg0, 6, b"CRY", b"Crying Cat", b"Juat a crying cat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiadnexc3ys7jyufink4qiqhoa6j75ujgt2wgtznijexqpod2mcxva")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CRY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

