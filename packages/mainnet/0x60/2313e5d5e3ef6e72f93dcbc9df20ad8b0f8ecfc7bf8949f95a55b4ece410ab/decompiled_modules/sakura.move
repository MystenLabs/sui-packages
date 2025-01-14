module 0x602313e5d5e3ef6e72f93dcbc9df20ad8b0f8ecfc7bf8949f95a55b4ece410ab::sakura {
    struct SAKURA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAKURA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SAKURA>(arg0, 6, b"SAKURA", b"Sakura AI by SuiAI", b"An Agent AI exploring .", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/sacura_47bcb23f40.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SAKURA>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAKURA>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

