module 0xa25af6e973e57b29838f8c117f688549748b616a76b9df8af4bfbdd4c1ec083e::bro {
    struct BRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRO>(arg0, 6, b"BRO", b"PandaBRO", x"5351554952592074686520506c61792d746f2d4561726e2028503245292067616d65206f6620746f6d6f72726f772c206973206865726520746f6461792021200a506c61792c206561726e2068617a656c6e7574732c20636f6e76657274207468656d20696e746f20746f6b656e732c206f7220757365207468656d20746f207570677261646520796f7572206368617261637465722c206561726e206576656e206d6f72652061636f726e732c206f722073656c6c20796f757220636861726163746572", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1723714917216_b766a399d99d1880d83f35eda56ef6eb_fe7cabe08d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BRO>>(v1);
    }

    // decompiled from Move bytecode v6
}

