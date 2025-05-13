module 0x5fad71cd86dfb03f3941571835b54fb2a94364ae54ac7f816224837ff424b662::king {
    struct KING has drop {
        dummy_field: bool,
    }

    fun init(arg0: KING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KING>(arg0, 6, b"KING", b"King Fizh", x"322c313030204e46547320636f6e71756572696e6720537569204b696e67646f6d210a0a4576657279206c6976696e67206265696e6720696e207468697320776f726c642063616e20626520617320677265617420617320746865697220647265616d732e204b696e672046697a68277320647265616d20697320746f20726570726573656e742068697320656e7469726520737065636965732c20616e6420746f20646f20736f2c206865206d757374206265636f6d65206120244b494e47", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeidfimt4c2h5p6o7jvu7klpixm2t33i2q3cofzaduk3ozheoprqfpm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KING>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<KING>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

