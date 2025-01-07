module 0xd76e74148e6d01e53b09a115c3888973fe29da511d2e39783f8d23868c7efe10::dos {
    struct DOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOS>(arg0, 9, b"DOS", b"Dasydj", x"49e280996d206a75737420747279696e67206d79206c75636b20f09f8d8020", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/20012ed6-e36d-4205-a83e-6faf219a4931.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOS>>(v1);
    }

    // decompiled from Move bytecode v6
}

