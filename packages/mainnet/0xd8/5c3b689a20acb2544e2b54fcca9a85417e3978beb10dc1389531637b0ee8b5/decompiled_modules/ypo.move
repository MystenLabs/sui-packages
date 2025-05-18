module 0xd85c3b689a20acb2544e2b54fcca9a85417e3978beb10dc1389531637b0ee8b5::ypo {
    struct YPO has drop {
        dummy_field: bool,
    }

    fun init(arg0: YPO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YPO>(arg0, 6, b"Ypo", b"Yupio ", x"446f206e6f74206275792c206974e2809973206a75737420612074657374", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1747569521173.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YPO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YPO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

