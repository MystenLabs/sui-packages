module 0x8a7206a53870f2875acff26c333fa2beec120fdc9217f1a3ae3d8a886dd76186::ngacengco {
    struct NGACENGCO has drop {
        dummy_field: bool,
    }

    fun init(arg0: NGACENGCO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NGACENGCO>(arg0, 9, b"NGACENGCO", b"NGACENG", b"Coin Ngaceng Dancuk", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c380615b-f156-4fb1-8f63-4c38b9ccd8bc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NGACENGCO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NGACENGCO>>(v1);
    }

    // decompiled from Move bytecode v6
}

