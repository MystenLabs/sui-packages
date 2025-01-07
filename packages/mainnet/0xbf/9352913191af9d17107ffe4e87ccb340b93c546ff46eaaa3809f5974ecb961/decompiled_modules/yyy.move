module 0xbf9352913191af9d17107ffe4e87ccb340b93c546ff46eaaa3809f5974ecb961::yyy {
    struct YYY has drop {
        dummy_field: bool,
    }

    fun init(arg0: YYY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YYY>(arg0, 1, b"yyy", b"yyy", x"6667646667646667c4916667", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<YYY>(&mut v2, 3452465265745540, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YYY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YYY>>(v1);
    }

    // decompiled from Move bytecode v6
}

