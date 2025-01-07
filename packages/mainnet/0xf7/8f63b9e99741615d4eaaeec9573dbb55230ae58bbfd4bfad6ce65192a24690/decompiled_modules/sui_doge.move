module 0xf78f63b9e99741615d4eaaeec9573dbb55230ae58bbfd4bfad6ce65192a24690::sui_doge {
    struct SUI_DOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUI_DOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUI_DOGE>(arg0, 9, b"Sui Doge", b"SDOGE", x"53756920446f67652069732061206d656d6520746f6b656e206f6e207468652053756920626c6f636b636861696e2c20626c656e64696e672074686520446f6765206d656d6527732066756e207769746820537569e280997320666173742c206c6f772d666565207472616e73616374696f6e7320666f72206120706c617966756c2063727970746f20657870657269656e63652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1843286822379757568/qD5_-G_7.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUI_DOGE>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUI_DOGE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUI_DOGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

