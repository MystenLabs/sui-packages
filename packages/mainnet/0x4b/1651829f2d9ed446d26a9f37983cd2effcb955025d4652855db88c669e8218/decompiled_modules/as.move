module 0x4b1651829f2d9ed446d26a9f37983cd2effcb955025d4652855db88c669e8218::as {
    struct AS has drop {
        dummy_field: bool,
    }

    fun init(arg0: AS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AS>(arg0, 9, b"AS", b"DFS", b"FD", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/46c02ab7-605c-42cd-98a4-8f12c1f3e7c2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AS>>(v1);
    }

    // decompiled from Move bytecode v6
}

