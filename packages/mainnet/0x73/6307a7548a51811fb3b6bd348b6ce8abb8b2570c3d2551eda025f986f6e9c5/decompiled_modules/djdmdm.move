module 0x736307a7548a51811fb3b6bd348b6ce8abb8b2570c3d2551eda025f986f6e9c5::djdmdm {
    struct DJDMDM has drop {
        dummy_field: bool,
    }

    fun init(arg0: DJDMDM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DJDMDM>(arg0, 9, b"DJDMDM", b"Hdmeme", b"Gxgccjj", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/140bec9e-f358-4576-9d46-c7e1450f723c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DJDMDM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DJDMDM>>(v1);
    }

    // decompiled from Move bytecode v6
}

