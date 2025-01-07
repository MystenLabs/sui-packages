module 0x20ab625ea9a89241f90c605f40ee6038f8325cdb0cfc937d03e2970fc15d7b29::hepoo {
    struct HEPOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: HEPOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HEPOO>(arg0, 9, b"HEPOO", b"Baby hepo", b"Bay hepoo and  grow hipo community this hepo mother is death alone", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ee607c0c-4ec4-4a9e-ae95-3670d5a4d94c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HEPOO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HEPOO>>(v1);
    }

    // decompiled from Move bytecode v6
}

