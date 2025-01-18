module 0x6ebd45473bff90e9e8de282b621a8886e578ef1e38727dbed3c089fb5495bd39::trump2077 {
    struct TRUMP2077 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMP2077, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMP2077>(arg0, 6, b"TRUMP2077", b"CyberTrump2077", b"The year is 2077. President Cyborg Trump has just become the 58th president. Crypto has taken over as the main form of currency and CyberTrump2077 has created an army of faithful holders on SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1737171190439.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRUMP2077>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMP2077>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

