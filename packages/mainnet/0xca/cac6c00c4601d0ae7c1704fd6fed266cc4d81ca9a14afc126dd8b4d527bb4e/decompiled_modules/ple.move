module 0xcacac6c00c4601d0ae7c1704fd6fed266cc4d81ca9a14afc126dd8b4d527bb4e::ple {
    struct PLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PLE>(arg0, 9, b"PLE", b"apple", b"The usual tongue twister", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/03561e4e-e815-43af-a111-c8e76b6d07b5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

