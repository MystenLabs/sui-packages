module 0xd4236c77afe0df92fe3ccf4aac0b65b2a26459f2eef8d8e9a56172414c7e1f54::hype {
    struct HYPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: HYPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HYPE>(arg0, 9, b"HYPE", b"HypeCoin", b"\"HypeCoin\" is a token that seeks to capture the energy of social media trends and hype. With a simple and striking name, HYPE focuses on an active community that loves to share and promote the token.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8d94c1b7-83de-47e2-91bb-0ed936e2f687.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HYPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HYPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

