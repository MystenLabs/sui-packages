module 0xf7d32330036729270bcd3ca2ab7c7e48e0a4da5193c41c21d80f4923e69db5f6::faked {
    struct FAKED has drop {
        dummy_field: bool,
    }

    fun init(arg0: FAKED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FAKED>(arg0, 9, b"FAKED", b"FakeDogs", b"Fake God", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/42bb411c-83e3-4551-ae27-661a9e5a73f5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FAKED>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FAKED>>(v1);
    }

    // decompiled from Move bytecode v6
}

