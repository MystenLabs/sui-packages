module 0x9f74bb4246af9c371103c39e673f72f65407c1cb6659190d5e5f6b4235941220::king {
    struct KING has drop {
        dummy_field: bool,
    }

    fun init(arg0: KING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KING>(arg0, 6, b"KING", b"Sui King Fizh", x"4c696665206973204d6f72652046756e6e792061742053656120244b494e4720436f6e71756572696e6720746865204f6365616e0a0a41726520796f75207374726f6e6720656e6f75676820746f20626520696e20726f796174793f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreici7el2x4kkvrdmxxpw65os4mlk2rlnrsbycda6wlv2i4a7wef63i")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KING>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<KING>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

