module 0x70b553de7d5f92623141bfe428cba25a7b55cded8ee06b5c7f0522477b499810::komodoidn {
    struct KOMODOIDN has drop {
        dummy_field: bool,
    }

    fun init(arg0: KOMODOIDN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KOMODOIDN>(arg0, 9, b"KOMODOIDN", b"KOMODO", b"KOMODO animal", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/faaf448e-9bf3-4c6f-9215-586dcf2a5bb7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KOMODOIDN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KOMODOIDN>>(v1);
    }

    // decompiled from Move bytecode v6
}

