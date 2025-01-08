module 0x1cee88db3976953c6faf8fcb82392a1949e4fe0bf20ba72f7ea3a79901ac3da::suisauce {
    struct SUISAUCE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISAUCE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISAUCE>(arg0, 6, b"SUISAUCE", x"737569f09f92a77361756365", x"496e2074686520776f726c64206f66205375692c20776527726520616c6c2061626f7574207468617420f09f92a7", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736294345964.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUISAUCE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISAUCE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

