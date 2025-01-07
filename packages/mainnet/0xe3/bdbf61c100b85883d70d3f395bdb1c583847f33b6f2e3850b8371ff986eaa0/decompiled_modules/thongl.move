module 0xe3bdbf61c100b85883d70d3f395bdb1c583847f33b6f2e3850b8371ff986eaa0::thongl {
    struct THONGL has drop {
        dummy_field: bool,
    }

    fun init(arg0: THONGL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<THONGL>(arg0, 9, b"THONGL", b"THONGLE", b"Hello ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/65bbb346-aaf5-4e0c-851f-aa32672b6715.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<THONGL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<THONGL>>(v1);
    }

    // decompiled from Move bytecode v6
}

