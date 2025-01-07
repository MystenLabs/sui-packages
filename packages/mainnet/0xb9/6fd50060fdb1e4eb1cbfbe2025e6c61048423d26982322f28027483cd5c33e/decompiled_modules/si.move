module 0xb96fd50060fdb1e4eb1cbfbe2025e6c61048423d26982322f28027483cd5c33e::si {
    struct SI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SI>(arg0, 9, b"SI", b"Social ", b"Dickies and his family were among ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d609ef8c-e48e-4b56-ab09-4b8866733d09.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SI>>(v1);
    }

    // decompiled from Move bytecode v6
}

