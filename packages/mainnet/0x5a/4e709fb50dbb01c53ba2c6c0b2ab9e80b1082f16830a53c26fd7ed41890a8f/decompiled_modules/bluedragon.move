module 0x5a4e709fb50dbb01c53ba2c6c0b2ab9e80b1082f16830a53c26fd7ed41890a8f::bluedragon {
    struct BLUEDRAGON has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUEDRAGON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUEDRAGON>(arg0, 9, b"BLUEDRAGON", b"Bdra", b"Bdra is blue dragon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0847e3cf-3816-44ba-af89-4cf63216e9a0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUEDRAGON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BLUEDRAGON>>(v1);
    }

    // decompiled from Move bytecode v6
}

