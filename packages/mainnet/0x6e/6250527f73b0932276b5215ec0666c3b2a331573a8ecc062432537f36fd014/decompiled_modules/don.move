module 0x6e6250527f73b0932276b5215ec0666c3b2a331573a8ecc062432537f36fd014::don {
    struct DON has drop {
        dummy_field: bool,
    }

    fun init(arg0: DON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DON>(arg0, 9, b"DON", b"Donlee", b"Donlee superhero", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8f336fe6-4401-45a3-94f5-179f7566cbf9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DON>>(v1);
    }

    // decompiled from Move bytecode v6
}

