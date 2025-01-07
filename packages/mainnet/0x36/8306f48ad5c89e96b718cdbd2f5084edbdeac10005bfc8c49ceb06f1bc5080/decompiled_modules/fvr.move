module 0x368306f48ad5c89e96b718cdbd2f5084edbdeac10005bfc8c49ceb06f1bc5080::fvr {
    struct FVR has drop {
        dummy_field: bool,
    }

    fun init(arg0: FVR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FVR>(arg0, 9, b"FVR", b"Finvera", x"46696e616e6369616c2046726565646f6d20616e642053656375726974790a4465736372697074696f6e3a2046696e7665726120656d626f64696573207468652069646561206f662066696e616e6369616c206c696265726174696f6e2c2070726f766964696e672075736572732077697468207365637572652c20646563656e7472616c697a65642c20616e64207472616e73706172656e74207472616e73616374696f6e732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/11e6bfb4-982b-4437-b128-e0791c94c37c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FVR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FVR>>(v1);
    }

    // decompiled from Move bytecode v6
}

