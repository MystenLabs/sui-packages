module 0x3cec00fcfe3ce4a15f394d27a4ff4c3862ca103ee3ceb85ede020417dddfd4c2::lrs {
    struct LRS has drop {
        dummy_field: bool,
    }

    fun init(arg0: LRS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LRS>(arg0, 9, b"LRS", b"LadyRose", b"Lady Rose Is Wish You The Best !", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5acdc88e-e42c-4a11-88b9-f95d5ea77ef8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LRS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LRS>>(v1);
    }

    // decompiled from Move bytecode v6
}

