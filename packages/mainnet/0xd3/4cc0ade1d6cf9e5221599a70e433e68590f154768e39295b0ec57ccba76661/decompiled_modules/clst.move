module 0xd34cc0ade1d6cf9e5221599a70e433e68590f154768e39295b0ec57ccba76661::clst {
    struct CLST has drop {
        dummy_field: bool,
    }

    fun init(arg0: CLST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CLST>(arg0, 6, b"CLST", b"Celestia", x"4d6565742043656c65737469612c20746865206f6666696369616c206d65726d616964206f662053756920616e6420746865206c6174657374206d656d652073656e736174696f6e202d206272696e67696e672074686520636861726d206f6620746865207365617320746f2074686520626c6f636b636861696e2e0a0a68747470733a2f2f742e6d652f2b4e4c672d446e73412d6a34314d544e6c", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1_B72_A929_4747_4_C70_97_FC_F655_C35523_C8_946e409b9e.WEBP")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CLST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CLST>>(v1);
    }

    // decompiled from Move bytecode v6
}

