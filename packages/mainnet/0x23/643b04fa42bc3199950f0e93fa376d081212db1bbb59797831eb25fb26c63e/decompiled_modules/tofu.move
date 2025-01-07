module 0x23643b04fa42bc3199950f0e93fa376d081212db1bbb59797831eb25fb26c63e::tofu {
    struct TOFU has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOFU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOFU>(arg0, 9, b"TOFU", b"Tofu", x"54c3a06f207068e1bb9b", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/83cdce8d-4020-43b3-a726-8673794a6a27.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOFU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOFU>>(v1);
    }

    // decompiled from Move bytecode v6
}

