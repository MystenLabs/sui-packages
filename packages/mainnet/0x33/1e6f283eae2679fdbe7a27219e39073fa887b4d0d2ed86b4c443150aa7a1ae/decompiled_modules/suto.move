module 0x331e6f283eae2679fdbe7a27219e39073fa887b4d0d2ed86b4c443150aa7a1ae::suto {
    struct SUTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUTO>(arg0, 9, b"SUTO", b"SuTopia", x"5375746f7069612028245355544f293a20546865206d656d6520746f6b656e206f66207468652053756920626c6f636b636861696e2c206f66666572696e6720612066756e20616e642075746f7069616e20766973696f6e206f6620646563656e7472616c697a65642063727970746f2e204275696c7420666f72206c61756768732c20636f6d6d756e6974792c20616e6420726964696e6720746865205355544f20776176652120f09f8c90", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1843370955000762368/TZP271Wq.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUTO>(&mut v2, 1110000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUTO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUTO>>(v1);
    }

    // decompiled from Move bytecode v6
}

