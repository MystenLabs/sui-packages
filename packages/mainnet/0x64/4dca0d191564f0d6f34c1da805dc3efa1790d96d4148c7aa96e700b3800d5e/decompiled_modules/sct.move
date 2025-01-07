module 0x644dca0d191564f0d6f34c1da805dc3efa1790d96d4148c7aa96e700b3800d5e::sct {
    struct SCT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCT>(arg0, 9, b"SCT", b"SUS CATS", x"53555320f09f98ba", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b619a3e4-262b-4278-bbe9-dcf16548a41a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SCT>>(v1);
    }

    // decompiled from Move bytecode v6
}

