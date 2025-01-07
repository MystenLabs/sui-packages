module 0x34716f38d59d73f227c8aa4da419e1c1d91bd762c1fbe2771def3c88d348c0da::alexander {
    struct ALEXANDER has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALEXANDER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ALEXANDER>(arg0, 9, b"ALEXANDER", b"MKD", b"Alexander the Great, created one of the largest empires of the ancient world in little over a decade.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8f38e820-8b19-4bff-a5b5-b00c9ed18dbe.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALEXANDER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ALEXANDER>>(v1);
    }

    // decompiled from Move bytecode v6
}

