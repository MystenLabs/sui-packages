module 0xecd9ec594ffea5111680d063f8c5010e8ff3f56599019ff7b73fcae3de63ee99::beluga {
    struct BELUGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BELUGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BELUGA>(arg0, 6, b"Beluga", b"BELUGA SUI", x"4b656570204275696c64696e67206f6e20737569206e6574776f726b2e0a42656c75676120737569206973206669727374206d656d652057696c6c20626f6e64656420746f646179", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreif6l5x7nhm57c6j7ri3ly5elcpxlrvh2lujyoazfhbexjfpspvih4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BELUGA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BELUGA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

