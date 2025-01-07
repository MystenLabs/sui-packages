module 0x5fd15feb46772de768d0c07a38a7e1b7e92c993f1a8e7edc1e4236eb622cd19e::caro {
    struct CARO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CARO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CARO>(arg0, 9, b"CARO", b"onecar", x"f09f9a977468652072616365f09f9a97", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fd60d478-804e-4a79-9341-6b072289115d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CARO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CARO>>(v1);
    }

    // decompiled from Move bytecode v6
}

