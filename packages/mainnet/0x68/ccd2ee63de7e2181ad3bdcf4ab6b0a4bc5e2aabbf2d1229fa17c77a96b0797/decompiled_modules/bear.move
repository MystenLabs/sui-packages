module 0x68ccd2ee63de7e2181ad3bdcf4ab6b0a4bc5e2aabbf2d1229fa17c77a96b0797::bear {
    struct BEAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEAR>(arg0, 9, b"BEAR", b"Pinky Bear", b"Pinky Bears", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/18b4ed8f-813c-49ba-a257-317f42f8e52f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BEAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

