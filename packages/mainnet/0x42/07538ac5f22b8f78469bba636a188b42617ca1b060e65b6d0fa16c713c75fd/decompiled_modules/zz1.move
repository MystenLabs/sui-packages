module 0x4207538ac5f22b8f78469bba636a188b42617ca1b060e65b6d0fa16c713c75fd::zz1 {
    struct ZZ1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZZ1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZZ1>(arg0, 9, b"ZZ1", b"zz1", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://steamm-assets.s3.amazonaws.com/token-icon.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZZ1>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZZ1>>(v1);
    }

    // decompiled from Move bytecode v6
}

