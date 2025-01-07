module 0x6135b5c0c5015def3e4f3df8b9bde39ff51937d415402117d9649f3f08b0506d::atm {
    struct ATM has drop {
        dummy_field: bool,
    }

    fun init(arg0: ATM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ATM>(arg0, 9, b"ATM", b"autumn", b"busy and full of days", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8909cf64-80da-4ea7-b287-b10e24133088.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ATM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ATM>>(v1);
    }

    // decompiled from Move bytecode v6
}

