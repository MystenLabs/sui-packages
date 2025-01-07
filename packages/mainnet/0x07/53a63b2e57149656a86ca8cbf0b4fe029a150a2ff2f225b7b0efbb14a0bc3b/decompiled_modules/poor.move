module 0x753a63b2e57149656a86ca8cbf0b4fe029a150a2ff2f225b7b0efbb14a0bc3b::poor {
    struct POOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: POOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POOR>(arg0, 9, b"POOR", b"Poor Coin", x"504f4f5220e280942061206d656d6520636f696e20666f722074686f73652077686f206b6e6f7720746865206a6f7973206f66206c6976696e67206f6e2061206275646765742120504f4f52206973206e6f74206a7573742063727970746f3b206974e2809973206120636c756220666f722074686f73652077686f206c6175676820696e207468652066616365206f662066696e616e6369616c206368616c6c656e6765732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/48e40307-f83c-40ad-8f3e-8bad4bf40d6e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POOR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<POOR>>(v1);
    }

    // decompiled from Move bytecode v6
}

