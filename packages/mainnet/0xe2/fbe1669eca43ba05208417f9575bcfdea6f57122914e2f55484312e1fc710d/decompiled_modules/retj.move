module 0xe2fbe1669eca43ba05208417f9575bcfdea6f57122914e2f55484312e1fc710d::retj {
    struct RETJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: RETJ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RETJ>(arg0, 9, b"RETJ", b"RETJEH", b"RETJ coin: More than just a coin, it's a community. A passionate group of indlividuals united by their love for memes and crypto. Invest in RETJ and become part of something special.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1795eb54-ef0d-4d4e-bc61-164192461200.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RETJ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RETJ>>(v1);
    }

    // decompiled from Move bytecode v6
}

