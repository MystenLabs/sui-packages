module 0x5316caac8c4383c3e40e6c34c45e57ea3513d97e0f3dfe8369b8d4a920bffb::suinet {
    struct SUINET has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINET, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SUINET>(arg0, 6, b"SUINET", b"Suinet AI by SuiAI", x"5375696e657420646f65736ee2809974206a757374206164617074e2809469742074616b6573206f7665722e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/bbd_a1baec77f5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUINET>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINET>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

