module 0x9e58170753a7cdca1bb5a5df5f43179b95985123da69d0003ff0fa596f4dcd92::holo {
    struct HOLO has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOLO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOLO>(arg0, 9, b"HOLO", b"holo", b"Holopump", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b436bdc7-6990-435d-8b4b-3390cc949c31.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOLO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HOLO>>(v1);
    }

    // decompiled from Move bytecode v6
}

