module 0x63c0d214db605200323b98e804b2f73258450ce7b504b5470487a33b298a339e::ogalipet27 {
    struct OGALIPET27 has drop {
        dummy_field: bool,
    }

    fun init(arg0: OGALIPET27, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OGALIPET27>(arg0, 9, b"OGALIPET27", b"Ogalipet", b"Funny", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b6ecc5b7-92b7-48db-b7e2-ab6dab6fe473.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OGALIPET27>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OGALIPET27>>(v1);
    }

    // decompiled from Move bytecode v6
}

