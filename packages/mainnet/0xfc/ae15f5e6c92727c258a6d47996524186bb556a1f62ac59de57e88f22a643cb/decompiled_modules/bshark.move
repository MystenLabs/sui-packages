module 0xfcae15f5e6c92727c258a6d47996524186bb556a1f62ac59de57e88f22a643cb::bshark {
    struct BSHARK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BSHARK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BSHARK>(arg0, 6, b"BSHARK", b"Bullshark ", x"4d65657420746865206661737465737420637265617475726520696e2074686520736561efbc81", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736953393409.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BSHARK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BSHARK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

