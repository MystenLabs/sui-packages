module 0x78215602fb3306184771c4900d2e74c6971f179fccf6fbb2d344976658b73d59::suipiens {
    struct SUIPIENS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPIENS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPIENS>(arg0, 6, b"SUIPIENS", b"Suipiens ", x"4f4720436f6d6d756e697479206f6e20245375692045636f73797374656d2e20200a4e6f77204f4720436f6d6d756e69747920746f6b656e206973206c6976652e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730964202318.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIPIENS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPIENS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

