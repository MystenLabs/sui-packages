module 0xe2cf88e1db2af95039821b5b2e5d278a49133b73b8142e92f27218a99fdfa1be::pdd {
    struct PDD has drop {
        dummy_field: bool,
    }

    fun init(arg0: PDD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PDD>(arg0, 9, b"PDD", b"P. Diddy", b"Eat, love, pray, buy memes!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/991dcdb5-8f3e-4d36-b9b3-11fb4800e736-Bad_Boy_Records_logo.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PDD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PDD>>(v1);
    }

    // decompiled from Move bytecode v6
}

