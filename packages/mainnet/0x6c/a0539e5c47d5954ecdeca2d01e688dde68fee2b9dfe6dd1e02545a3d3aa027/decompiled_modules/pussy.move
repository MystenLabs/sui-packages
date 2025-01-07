module 0x6ca0539e5c47d5954ecdeca2d01e688dde68fee2b9dfe6dd1e02545a3d3aa027::pussy {
    struct PUSSY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUSSY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUSSY>(arg0, 6, b"Pussy", b"Pussy ", b"It's $Pussy time.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731389993674.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PUSSY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUSSY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

