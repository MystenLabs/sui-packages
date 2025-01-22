module 0x8a8685cee9a44b23dbb42a9220346689184f6d80831b84ddf85484e6d212d27::squis {
    struct SQUIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SQUIS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SQUIS>(arg0, 6, b"SQUIS", b"Squishiverse by SuiAI", x"546865205371756973686976657273652c20776865726520637574652c206469676974616c20636f6c6c65637469626c657320636f6d6520746f206c69666520f09f9299", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/j_B_Ojs_Tn_S_400x400_85eebee920.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SQUIS>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SQUIS>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

