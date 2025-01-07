module 0x456b89fcc3c2cb1bd96c98912f7e0152c0ffffda04600d16fe9b7db95264bd81::bebe {
    struct BEBE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEBE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEBE>(arg0, 6, b"BEBE", b"BeBe On Sui", x"4265626520697320746865202042726f74686572206f6620506570652c20616c736f206b6e6f776e2061732042726574742773207374657062726f746865722120446f206e6f74206d69737320686973207269736520746f2066616d6520617320686520666967687473206f666620616c6c20746865206265617273206f6620746865206d61726b6574212042656265206973206865726520746f2072616c6c792074686520636f6d6d756e69747920616e64206c65616420746865206368617267652c2073686f77696e672065766572796f6e6520746865207472756520706f776572206f66206d656d657320696e207468652063727970746f20776f726c642e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Uu_Agpcm_Dw_Vkpy_Yh_Q55arz_Npu_Ksbmgr_Kgnc28_Ln_Xo_U8sd_16dc5cc60d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEBE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BEBE>>(v1);
    }

    // decompiled from Move bytecode v6
}

