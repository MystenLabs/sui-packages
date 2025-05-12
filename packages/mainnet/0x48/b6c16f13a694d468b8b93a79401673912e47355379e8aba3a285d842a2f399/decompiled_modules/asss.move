module 0x48b6c16f13a694d468b8b93a79401673912e47355379e8aba3a285d842a2f399::asss {
    struct ASSS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASSS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASSS>(arg0, 9, b"ASSS", b"AS", b"ASSSS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dev-file-walletapp.waveonsui.com/images/wave-pumps/576f7760-199b-4270-8abf-30de5a3f4412.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASSS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ASSS>>(v1);
    }

    // decompiled from Move bytecode v6
}

