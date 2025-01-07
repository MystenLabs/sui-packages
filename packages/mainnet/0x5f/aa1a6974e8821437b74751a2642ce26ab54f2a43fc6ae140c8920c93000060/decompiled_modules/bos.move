module 0x5faa1a6974e8821437b74751a2642ce26ab54f2a43fc6ae140c8920c93000060::bos {
    struct BOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOS>(arg0, 9, b"BOS", b"The Book of Sui", x"54686520426f6f6b206f66205375692028424f5329206973206120746f6b656e206f6e207468652053756920626c6f636b636861696e2c2073796d626f6c697a696e6720646973636f7665727920616e6420636f6d6d756e6974792d64726976656e2067726f7774682e20456163682063686170746572206f6620424f5320756e6c6f636b7320726577617264732c20676f7665726e616e63652c20616e64206e65772066656174757265732c20696e766974696e6720686f6c6465727320746f2062652070617274206f6620537569e28099732065766f6c76696e672073746f72792e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1118510036488208385/vpSzuyFi.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BOS>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOS>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOS>>(v1);
    }

    // decompiled from Move bytecode v6
}

