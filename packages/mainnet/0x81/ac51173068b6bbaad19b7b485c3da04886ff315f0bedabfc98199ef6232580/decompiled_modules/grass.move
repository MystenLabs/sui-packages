module 0x81ac51173068b6bbaad19b7b485c3da04886ff315f0bedabfc98199ef6232580::grass {
    struct GRASS has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRASS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GRASS>(arg0, 9, b"GRASS", b"GRASS IO", x"4f7572206d697373696f6e20697320746f207265646566696e6520496e7465726e657420696e63656e74697665207374727563747572657320f09f8cb120", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/77a33632-4065-477c-b530-6224b104e47c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRASS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GRASS>>(v1);
    }

    // decompiled from Move bytecode v6
}

