module 0x2690b3e368b44accacb141e23f253c8749b12b0a9de1ec6687f57541d3b27624::hue {
    struct HUE has drop {
        dummy_field: bool,
    }

    fun init(arg0: HUE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HUE>(arg0, 9, b"HUE", b"Hue", b"Hue yeu", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/bd9857ff-8234-45ef-81bc-b096ff80b5b3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HUE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HUE>>(v1);
    }

    // decompiled from Move bytecode v6
}

