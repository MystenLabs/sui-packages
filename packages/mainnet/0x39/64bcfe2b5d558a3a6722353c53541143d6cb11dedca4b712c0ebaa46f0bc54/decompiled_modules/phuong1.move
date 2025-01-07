module 0x3964bcfe2b5d558a3a6722353c53541143d6cb11dedca4b712c0ebaa46f0bc54::phuong1 {
    struct PHUONG1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: PHUONG1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PHUONG1>(arg0, 9, b"PHUONG1", b"phuong", b"dkdhagadjjssd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/29ca9a44-1e98-485e-8030-a75d46682efa.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PHUONG1>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PHUONG1>>(v1);
    }

    // decompiled from Move bytecode v6
}

