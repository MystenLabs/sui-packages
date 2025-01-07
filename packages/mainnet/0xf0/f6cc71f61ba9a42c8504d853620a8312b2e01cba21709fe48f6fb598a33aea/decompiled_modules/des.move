module 0xf0f6cc71f61ba9a42c8504d853620a8312b2e01cba21709fe48f6fb598a33aea::des {
    struct DES has drop {
        dummy_field: bool,
    }

    fun init(arg0: DES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DES>(arg0, 9, b"DES", b"Desteany", b"LFF", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d2743be1-9e4f-4121-a2ae-8f841020968d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DES>>(v1);
    }

    // decompiled from Move bytecode v6
}

