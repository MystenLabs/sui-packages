module 0xc411dd42f6cff60b62d6f3b63fc024a36129f232ea7c04ce2f79731f364940ab::bubblo {
    struct BUBBLO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUBBLO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUBBLO>(arg0, 6, b"Bubblo", b"BUBBLO", x"54696e792024427562626c6f2c20626967206f6365616e2c206e6f20475053200a0a4a6f696e20427562626c6f206f6e2069747320756e7072656469637461626c65206a6f75726e6579207468726f75676820746865206465707468732c207768657265206576657279207761766520697320616e20616476656e747572652c20616e642065766572792063757272656e742069732061206e657720747769737420696e207468652073746f72792e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_09_03_22_20_12966e756f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUBBLO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUBBLO>>(v1);
    }

    // decompiled from Move bytecode v6
}

