module 0x66f17b8009dacf18d681918cb197d26d0448ae1ba7b08686072efcefc0bbfba3::pepi {
    struct PEPI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPI>(arg0, 9, b"PEPI", b"PEPE SUI", b"no description, just for fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7320d961-bbd5-415e-b9d0-90464709a72d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PEPI>>(v1);
    }

    // decompiled from Move bytecode v6
}

