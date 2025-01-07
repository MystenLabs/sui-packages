module 0x872e4860f8978f66704dba4e71360b2cb4dd678d65588fc1e2e5a93bbeb64f55::bco {
    struct BCO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BCO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BCO>(arg0, 9, b"BCO", b"Brian Ceo", b"Fun and game", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7514f34e-92bb-4b75-814e-46a1e9af5b95.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BCO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BCO>>(v1);
    }

    // decompiled from Move bytecode v6
}

