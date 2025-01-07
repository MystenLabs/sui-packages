module 0x7df08973c431f9444abfc243070405c75151bba99b0a61367e2fd057440c403e::pktmeme {
    struct PKTMEME has drop {
        dummy_field: bool,
    }

    fun init(arg0: PKTMEME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PKTMEME>(arg0, 9, b"PKTMEME", b"Puttotalk", b"Talk or silen", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/744e0416-92c2-4688-b8c6-034790f2f5b2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PKTMEME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PKTMEME>>(v1);
    }

    // decompiled from Move bytecode v6
}

