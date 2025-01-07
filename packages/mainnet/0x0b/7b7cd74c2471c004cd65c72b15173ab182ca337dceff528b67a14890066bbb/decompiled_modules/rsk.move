module 0xb7b7cd74c2471c004cd65c72b15173ab182ca337dceff528b67a14890066bbb::rsk {
    struct RSK has drop {
        dummy_field: bool,
    }

    fun init(arg0: RSK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RSK>(arg0, 9, b"RSK", b"RASQEE ", b"Better days ahead", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f3a10ed6-5817-4b19-a45a-f3d7221c475e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RSK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RSK>>(v1);
    }

    // decompiled from Move bytecode v6
}

