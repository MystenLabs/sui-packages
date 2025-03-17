module 0x928b7ccf87991295f0d66d0fa289e25aa3b4684eef31571d32a91168705526bb::pb {
    struct PB has drop {
        dummy_field: bool,
    }

    fun init(arg0: PB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PB>(arg0, 9, b"PB", b"picbox", x"62e1baad74207468e1baa779206e676fe1baa169206769616f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5f580aa1-18af-4c88-b8b3-b9be31b4780b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PB>>(v1);
    }

    // decompiled from Move bytecode v6
}

