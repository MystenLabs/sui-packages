module 0x3d4a8420c8fa7d1d2465598945d029028a792847ac62e8cd2b2c650a51e658b8::bubl {
    struct BUBL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUBL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUBL>(arg0, 6, b"BUBL", b"BUBL on SUI", x"427562626c696e67206f6e20405375694e6574776f726b20746f206d616b65206672656e732e0a484156452046554e205749544820425542424c452120534f4152205749544820425542424c452120425542424c4520495421", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731345990919.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BUBL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUBL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

