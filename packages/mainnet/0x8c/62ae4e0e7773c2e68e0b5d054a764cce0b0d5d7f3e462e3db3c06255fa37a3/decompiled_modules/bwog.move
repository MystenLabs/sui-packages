module 0x8c62ae4e0e7773c2e68e0b5d054a764cce0b0d5d7f3e462e3db3c06255fa37a3::bwog {
    struct BWOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BWOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BWOG>(arg0, 6, b"BWOG", b"Blue Fwog", b"its just a Bwog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeigjmaea35jztrg3sm4l7huoqxdby47hpwwjdiiw6x3rcufsaolvle")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BWOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BWOG>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

