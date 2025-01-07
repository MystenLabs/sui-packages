module 0x5c5a1b1ddae4312b7d4b5c66011e5b8f8725ae6ea6cbcf9f4fe4072bf1ac521::ownsbbd {
    struct OWNSBBD has drop {
        dummy_field: bool,
    }

    fun init(arg0: OWNSBBD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OWNSBBD>(arg0, 9, b"OWNSBBD", b"iekwne", b"hebw", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b6f6927d-8a11-4eda-80af-0179d152fd6d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OWNSBBD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OWNSBBD>>(v1);
    }

    // decompiled from Move bytecode v6
}

