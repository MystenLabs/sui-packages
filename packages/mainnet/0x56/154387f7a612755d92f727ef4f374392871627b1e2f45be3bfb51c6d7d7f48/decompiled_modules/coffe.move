module 0x56154387f7a612755d92f727ef4f374392871627b1e2f45be3bfb51c6d7d7f48::coffe {
    struct COFFE has drop {
        dummy_field: bool,
    }

    fun init(arg0: COFFE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COFFE>(arg0, 9, b"COFFE", b"Black", b"Black coffe", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/73e70b03-5279-4580-87bc-1071ab41709c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COFFE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COFFE>>(v1);
    }

    // decompiled from Move bytecode v6
}

