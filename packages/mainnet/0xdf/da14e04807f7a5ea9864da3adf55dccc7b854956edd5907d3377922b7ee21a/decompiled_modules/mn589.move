module 0xdfda14e04807f7a5ea9864da3adf55dccc7b854956edd5907d3377922b7ee21a::mn589 {
    struct MN589 has drop {
        dummy_field: bool,
    }

    fun init(arg0: MN589, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MN589>(arg0, 6, b"MN589", b"Moon589", x"4d6f6f6e353839206973206120636f6d6d756e6974792d64726976656e206d656d6520746f6b656e206f6e207468652053756920626c6f636b636861696e2e0a4e6f20726f61646d61702c206e6f2070726f6d6973657320206a757374206e756d626572732c2076696265732c20616e642061207368617265642062656c696566207468617420353839206973206e6f742072616e646f6d2e0a4372656174656420666f722066756e2c206578706572696d656e746174696f6e2c20616e642074686520737069726974206f66206f6e2d636861696e206368616f732e20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000062681_313bc8f94f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MN589>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MN589>>(v1);
    }

    // decompiled from Move bytecode v6
}

