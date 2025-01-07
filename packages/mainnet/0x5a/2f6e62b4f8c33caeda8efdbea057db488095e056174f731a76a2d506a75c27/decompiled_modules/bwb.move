module 0x5a2f6e62b4f8c33caeda8efdbea057db488095e056174f731a76a2d506a75c27::bwb {
    struct BWB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BWB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BWB>(arg0, 9, b"BWB", b"BST", b"Social Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/44d08a87-bf2f-40e0-b58f-fad7e97821c7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BWB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BWB>>(v1);
    }

    // decompiled from Move bytecode v6
}

