module 0xa33a7df943806398442e8ae34d3d739d3ecee13ba65c90ebb8b65e2bc464ca08::rizo {
    struct RIZO has drop {
        dummy_field: bool,
    }

    fun init(arg0: RIZO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RIZO>(arg0, 6, b"RIZO", b"Tesla Hedgehog Mascot", x"5465736c61204865646765686f67204d6173636f740a4d656d65636f696e207769746820746865206d6f73742072697a7a206f6e205375690a0a4d6f7665206f76657220646f67732c2074686520657261206f6620746865206865646765686f6720686173206172726976656421204d6565742052697a6f2c20456c6f6e20616e64205465736c61206661766f726974652068656467686f67", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifc6anl2lcyd4utgoghzzw6xsota7uhmutfh4kipzjm6z3rzyq654")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RIZO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<RIZO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

