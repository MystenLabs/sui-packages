module 0xac99ab284bb497f17c932b35ee8e300c572d668d85f1cb2547325751086cecd0::suiiiiii {
    struct SUIIIIII has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIIIIII, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIIIIII>(arg0, 9, b"SUIIIIII", x"e29abdefb88f53756969696969", b"Official token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIIIIII>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIIIIII>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIIIIII>>(v1);
    }

    // decompiled from Move bytecode v6
}

