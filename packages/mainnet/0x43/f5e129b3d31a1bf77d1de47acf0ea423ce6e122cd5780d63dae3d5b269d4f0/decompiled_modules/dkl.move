module 0x43f5e129b3d31a1bf77d1de47acf0ea423ce6e122cd5780d63dae3d5b269d4f0::dkl {
    struct DKL has drop {
        dummy_field: bool,
    }

    fun init(arg0: DKL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DKL>(arg0, 9, b"DKL", b"Dark Land", b"DARK LAND TOKEN IS OPEN FOR TRADING ...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/47e0c229-6a74-4767-8540-238d7897d3a2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DKL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DKL>>(v1);
    }

    // decompiled from Move bytecode v6
}

