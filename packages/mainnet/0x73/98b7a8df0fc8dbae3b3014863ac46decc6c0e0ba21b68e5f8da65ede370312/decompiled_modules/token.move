module 0x7398b7a8df0fc8dbae3b3014863ac46decc6c0e0ba21b68e5f8da65ede370312::token {
    struct TOKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOKEN>(arg0, 6, b"RandomName", b"RandomName", b"RandomName", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"data:image/png;base64")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TOKEN>(&mut v2, 69000000, @0xc4e2cbce489934df8ff4bbabe69d2ae672c4871a34859b769bef2309eaded7a3, arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TOKEN>>(v1, @0xc4e2cbce489934df8ff4bbabe69d2ae672c4871a34859b769bef2309eaded7a3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOKEN>>(v2, @0xc4e2cbce489934df8ff4bbabe69d2ae672c4871a34859b769bef2309eaded7a3);
    }

    public entry fun update_name2<T0>(arg0: &0x2::coin::TreasuryCap<T0>, arg1: &mut 0x2::coin::CoinMetadata<T0>, arg2: 0x1::string::String) {
        0x2::coin::update_name<T0>(arg0, arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

