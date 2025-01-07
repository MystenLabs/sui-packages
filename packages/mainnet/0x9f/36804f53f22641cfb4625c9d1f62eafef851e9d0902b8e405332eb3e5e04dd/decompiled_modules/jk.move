module 0x9f36804f53f22641cfb4625c9d1f62eafef851e9d0902b8e405332eb3e5e04dd::jk {
    struct JK has drop {
        dummy_field: bool,
    }

    fun init(arg0: JK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JK>(arg0, 9, b"JK", b"Joker", b"We love joker ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/49504a73-95a9-428c-ad3f-bc888641745a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JK>>(v1);
    }

    // decompiled from Move bytecode v6
}

