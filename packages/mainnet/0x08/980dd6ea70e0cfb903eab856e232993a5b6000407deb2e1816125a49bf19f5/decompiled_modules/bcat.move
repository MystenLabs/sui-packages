module 0x8980dd6ea70e0cfb903eab856e232993a5b6000407deb2e1816125a49bf19f5::bcat {
    struct BCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BCAT>(arg0, 6, b"BCat", b"BatCat", b"A cat goes to Gotham", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731001806824.jfif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BCAT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BCAT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

