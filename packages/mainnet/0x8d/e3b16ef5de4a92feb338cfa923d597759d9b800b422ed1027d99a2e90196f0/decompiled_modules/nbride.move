module 0x8de3b16ef5de4a92feb338cfa923d597759d9b800b422ed1027d99a2e90196f0::nbride {
    struct NBRIDE has drop {
        dummy_field: bool,
    }

    fun init(arg0: NBRIDE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NBRIDE>(arg0, 9, b"NBRIDE", b"BRIDE", b"BRIDE OF THE DEAD", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6bdca393-e041-4cb9-ae7b-fc51b55b2377.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NBRIDE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NBRIDE>>(v1);
    }

    // decompiled from Move bytecode v6
}

