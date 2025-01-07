module 0x323715a78a14809cf1c96b6929ff9208b40b05fe3e0f43d59cace7789aabb47c::yae {
    struct YAE has drop {
        dummy_field: bool,
    }

    fun init(arg0: YAE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YAE>(arg0, 9, b"YAE", b"Yaelah", b"Your All Employee ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/81ced826-c387-4c82-af56-b5800e7fca26.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YAE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YAE>>(v1);
    }

    // decompiled from Move bytecode v6
}

