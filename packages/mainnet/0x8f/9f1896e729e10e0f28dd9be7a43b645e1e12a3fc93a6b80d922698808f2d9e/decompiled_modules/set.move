module 0x8f9f1896e729e10e0f28dd9be7a43b645e1e12a3fc93a6b80d922698808f2d9e::set {
    struct SET has drop {
        dummy_field: bool,
    }

    fun init(arg0: SET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SET>(arg0, 9, b"SET", b"sunset", b"REEEED", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/71eec4eb-1771-43e1-9b71-580c631dbc50.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SET>>(v1);
    }

    // decompiled from Move bytecode v6
}

