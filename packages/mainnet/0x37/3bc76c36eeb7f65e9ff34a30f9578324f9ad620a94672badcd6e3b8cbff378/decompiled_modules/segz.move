module 0x373bc76c36eeb7f65e9ff34a30f9578324f9ad620a94672badcd6e3b8cbff378::segz {
    struct SEGZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEGZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEGZ>(arg0, 9, b"SEGZ", b"shadrach ", b"I am one of a kind ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/53632d91-4b5a-4808-911d-95c55e76a209.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEGZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SEGZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

