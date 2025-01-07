module 0x999e8d8047453d6dbaf693c05643e616bd0eca06daf8eebdd0ce39b3344c84a0::dgsggsdag {
    struct DGSGGSDAG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DGSGGSDAG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DGSGGSDAG>(arg0, 9, b"DGSGGSDAG", b"SGfh", b"GSGDSfdsafgasd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a42b570f-b418-4299-b90b-09a9f09bcb34.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DGSGGSDAG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DGSGGSDAG>>(v1);
    }

    // decompiled from Move bytecode v6
}

