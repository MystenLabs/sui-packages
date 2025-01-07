module 0x56d03971563e85c54ab4b1fd75d23129b62b99e17c319b0d4eb1158c7b4eda66::luna {
    struct LUNA has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUNA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LUNA>(arg0, 9, b"LUNA", b"Luna", b"LUNA Rug", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/12404401-226b-47ba-853a-6432fe8722ab.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUNA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LUNA>>(v1);
    }

    // decompiled from Move bytecode v6
}

