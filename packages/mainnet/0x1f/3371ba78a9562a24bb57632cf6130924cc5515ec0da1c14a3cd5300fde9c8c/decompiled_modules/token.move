module 0x1f3371ba78a9562a24bb57632cf6130924cc5515ec0da1c14a3cd5300fde9c8c::token {
    struct TOKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOKEN>(arg0, 6, b"test2.", b"test", b".", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"data:image/png;base64")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TOKEN>(&mut v2, 69000000, @0xa7d37541028160e6f6335bc00cd659f3ff174f5adf5c4b57ab044f59476688e7, arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TOKEN>>(v1, @0xc4e2cbce489934df8ff4bbabe69d2ae672c4871a34859b769bef2309eaded7a3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOKEN>>(v2, @0xc4e2cbce489934df8ff4bbabe69d2ae672c4871a34859b769bef2309eaded7a3);
    }

    public entry fun update_name2<T0>(arg0: &0x2::coin::TreasuryCap<T0>, arg1: &mut 0x2::coin::CoinMetadata<T0>, arg2: 0x1::string::String) {
        0x2::coin::update_name<T0>(arg0, arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

