module 0x624756ade305c6670252a3e9583e29bd12c9fd198c262f226ffe81549d17296::cetus {
    struct CETUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CETUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CETUS>(arg0, 9, b"CETUS", b"Cetuss", b"Best in defi projects and dapps creating and management. A utility token with premium use case. Dive into Cetus space let's grind. Best in defi projects and dapps creating and management", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a7879839-0d43-426c-b346-60524dd0b84d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CETUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CETUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

