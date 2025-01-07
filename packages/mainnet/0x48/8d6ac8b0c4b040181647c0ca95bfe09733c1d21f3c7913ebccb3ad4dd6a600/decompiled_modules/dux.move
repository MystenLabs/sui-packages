module 0x488d6ac8b0c4b040181647c0ca95bfe09733c1d21f3c7913ebccb3ad4dd6a600::dux {
    struct DUX has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUX>(arg0, 9, b"DUX", b"dudu", b"A handsome man", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b3c1c4c3-9c95-4325-afa6-d743a05ce4d8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DUX>>(v1);
    }

    // decompiled from Move bytecode v6
}

