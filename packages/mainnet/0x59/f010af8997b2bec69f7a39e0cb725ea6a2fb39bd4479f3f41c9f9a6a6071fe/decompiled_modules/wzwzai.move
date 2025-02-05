module 0x59f010af8997b2bec69f7a39e0cb725ea6a2fb39bd4479f3f41c9f9a6a6071fe::wzwzai {
    struct WZWZAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: WZWZAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WZWZAI>(arg0, 9, b"WZWZAI", b"WZWZ", b"WZWZAI Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/435d61da-d250-49c7-8601-18c057a21799.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WZWZAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WZWZAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

