module 0x1689606b7335a14d664f2e64adae66bbadb0bdf38a2d51706276e849f2be10e::confirmation {
    struct CONFIRMATION has drop {
        dummy_field: bool,
    }

    fun init(arg0: CONFIRMATION, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CONFIRMATION>(arg0, 6, b"CONFIRMATION", b"confirm", b"Dont buy this, testing bots", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifx45ct25m3ifyp3o6pxo32di24a24gcik3wy63f456l4s3t7i4mq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CONFIRMATION>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CONFIRMATION>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

