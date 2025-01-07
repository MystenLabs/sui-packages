module 0xf433e87cd5f5e417ff90efd35711fd7810c528f3d7ffcb37237dfbe73ebdb29a::rb {
    struct RB has drop {
        dummy_field: bool,
    }

    fun init(arg0: RB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RB>(arg0, 9, b"RB", b"Ribon", b"Is a token use to sell hair band", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6d9cb903-13e1-47a4-bf10-d5c7aec77eb0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RB>>(v1);
    }

    // decompiled from Move bytecode v6
}

