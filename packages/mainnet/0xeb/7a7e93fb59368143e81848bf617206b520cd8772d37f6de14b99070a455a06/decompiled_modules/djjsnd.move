module 0xeb7a7e93fb59368143e81848bf617206b520cd8772d37f6de14b99070a455a06::djjsnd {
    struct DJJSND has drop {
        dummy_field: bool,
    }

    fun init(arg0: DJJSND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DJJSND>(arg0, 9, b"DJJSND", b"Syshwj", b"Dbckfkdkj", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9da70bbc-5c06-4375-bf64-cb54b6f6c88b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DJJSND>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DJJSND>>(v1);
    }

    // decompiled from Move bytecode v6
}

