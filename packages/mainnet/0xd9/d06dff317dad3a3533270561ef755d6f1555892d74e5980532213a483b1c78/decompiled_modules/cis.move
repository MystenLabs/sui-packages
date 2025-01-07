module 0xd9d06dff317dad3a3533270561ef755d6f1555892d74e5980532213a483b1c78::cis {
    struct CIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CIS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CIS>(arg0, 9, b"CIS", b"Catinscarf", b"Just a cute cat in a pink scarf", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a46e312c-2d42-4bc5-b418-4996102fcbd1-IMG_5249.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CIS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CIS>>(v1);
    }

    // decompiled from Move bytecode v6
}

