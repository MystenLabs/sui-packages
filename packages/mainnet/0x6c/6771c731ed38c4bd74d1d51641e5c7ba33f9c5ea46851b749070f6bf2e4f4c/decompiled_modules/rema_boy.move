module 0x6c6771c731ed38c4bd74d1d51641e5c7ba33f9c5ea46851b749070f6bf2e4f4c::rema_boy {
    struct REMA_BOY has drop {
        dummy_field: bool,
    }

    fun init(arg0: REMA_BOY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REMA_BOY>(arg0, 9, b"REMA_BOY", b"Rema", b"Just for fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5ef44dc2-2924-4679-a461-62d9f48416be.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REMA_BOY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<REMA_BOY>>(v1);
    }

    // decompiled from Move bytecode v6
}

