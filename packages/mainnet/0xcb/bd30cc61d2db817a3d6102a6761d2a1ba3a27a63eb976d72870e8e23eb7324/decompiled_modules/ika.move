module 0xcbbd30cc61d2db817a3d6102a6761d2a1ba3a27a63eb976d72870e8e23eb7324::ika {
    struct IKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: IKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IKA>(arg0, 6, b"IKA", b"Inksack", x"496b6120697320746865206669727374207375622d7365636f6e64204d5043206e6574776f726b2c207363616c696e6720746f2031302c3030302074707320616e642068756e6472656473206f66207369676e6572206e6f6465732c2077697468207a65726f2d74727573742073656375726974792e0a506f776572696e67206d756c74692d636861696e20636f6f7264696e6174696f6e206f6e207468652053756920626c6f636b636861696e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ika_7f42463204.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IKA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<IKA>>(v1);
    }

    // decompiled from Move bytecode v6
}

