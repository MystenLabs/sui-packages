module 0xf6bd40a4d32224115e4d21174fce405b6992d6949dbc49188fa1d14bf0d99eaa::suim {
    struct SUIM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIM, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SUIM>(arg0, 6, b"SUIM", b"Sui-meme", x"4d656574205375692d6d656d652c20706f7765726564206279204d656d65204d617374657220537569202d206120676f6f66792063727970746f206865726f2077697468206120626c6f636b636861696e20636170652c20626174746c696e672067617320666565732077697468206d656d657321205469702063726561746f72732c207374616b6520666f7220726577617264732c20616e6420766f7465207769746820245355494d206f6e2074686520537569206e6574776f726b2e204c6574e2809973206c6175676820746f20746865206d6f6f6e212e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Whats_App_Image_2025_07_19_at_00_37_49_53f33983_3f5acc0936.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIM>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIM>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

