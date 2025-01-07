module 0x63ceca92c0b6c607245df85b3c5f2a624abc8f12f538c4971ecb9c50677c493b::snx {
    struct SNX has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNX>(arg0, 9, b"SNX", b"Sunusu", b"Snxtoken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6b8b5f56-bf3f-4f4f-887b-9554e40b6a94.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SNX>>(v1);
    }

    // decompiled from Move bytecode v6
}

