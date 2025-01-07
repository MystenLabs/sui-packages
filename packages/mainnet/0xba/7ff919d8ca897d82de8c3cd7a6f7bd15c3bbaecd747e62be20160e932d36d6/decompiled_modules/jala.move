module 0xba7ff919d8ca897d82de8c3cd7a6f7bd15c3bbaecd747e62be20160e932d36d6::jala {
    struct JALA has drop {
        dummy_field: bool,
    }

    fun init(arg0: JALA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JALA>(arg0, 9, b"JALA", b"Jake Chill", b"Jake Chill ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a5ba85f4-d08d-43b2-9a77-8bed06f92b77.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JALA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JALA>>(v1);
    }

    // decompiled from Move bytecode v6
}

