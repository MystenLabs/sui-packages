module 0xf17393b95ff0c49f77b3ca4af0599f536f31b25ad915b3a8770757fdbd04e552::krl {
    struct KRL has drop {
        dummy_field: bool,
    }

    fun init(arg0: KRL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KRL>(arg0, 9, b"KRL", b"Krilin", b"Krilin a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/dc2bde62-c8d8-440a-a614-587ef5038142.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KRL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KRL>>(v1);
    }

    // decompiled from Move bytecode v6
}

