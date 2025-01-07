module 0x300bd98524626b64e9a39b755d7d42457a3bd06dac1f3257199a5b42139ec3fe::ilme {
    struct ILME has drop {
        dummy_field: bool,
    }

    fun init(arg0: ILME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ILME>(arg0, 9, b"ILME", b"ilmeaalim", b"This memecoin is created by Youtuber, Muqaddas Shahzad: https://youtube.com/ilmeaalim - https://youtube.com/@crypto1O1", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b2a649cd-04c1-4a76-b66d-2bacc29adf94.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ILME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ILME>>(v1);
    }

    // decompiled from Move bytecode v6
}

