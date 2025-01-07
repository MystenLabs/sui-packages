module 0xcbd812d7c20f48a709ae76e5ce6738a6f2fc1e7ac35fac96bef5f669355a05b7::jjt {
    struct JJT has drop {
        dummy_field: bool,
    }

    fun init(arg0: JJT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JJT>(arg0, 9, b"JJT", b"Jet", b"Always fast in the sky", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e04c3791-97ce-499b-90ad-b1371284d23b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JJT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JJT>>(v1);
    }

    // decompiled from Move bytecode v6
}

