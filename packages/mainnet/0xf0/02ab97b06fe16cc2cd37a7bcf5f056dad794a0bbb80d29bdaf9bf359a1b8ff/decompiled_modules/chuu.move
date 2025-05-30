module 0xf002ab97b06fe16cc2cd37a7bcf5f056dad794a0bbb80d29bdaf9bf359a1b8ff::chuu {
    struct CHUU has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHUU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHUU>(arg0, 6, b"CHUU", b"Chuu On Sui", x"4920646f6e2774206b6e6f7720776861742049276d20646f696e672e0a4275742049206c6f6f6b20677265617420646f696e672069742e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibcu2v76cva5h4ziyphrg5hev2i5vpma4azvbg52x3xo2ydv5fujy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHUU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CHUU>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

