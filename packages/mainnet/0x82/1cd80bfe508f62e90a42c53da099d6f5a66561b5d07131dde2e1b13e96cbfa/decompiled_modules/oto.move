module 0x821cd80bfe508f62e90a42c53da099d6f5a66561b5d07131dde2e1b13e96cbfa::oto {
    struct OTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: OTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OTO>(arg0, 9, b"OTO", b"Otong", b"Otong Dolax", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/39ee4b31-8467-4f28-b5dc-fd9a0a3adcda.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OTO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OTO>>(v1);
    }

    // decompiled from Move bytecode v6
}

