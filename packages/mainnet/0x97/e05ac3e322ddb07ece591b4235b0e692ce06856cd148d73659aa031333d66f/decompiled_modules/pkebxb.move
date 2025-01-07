module 0x97e05ac3e322ddb07ece591b4235b0e692ce06856cd148d73659aa031333d66f::pkebxb {
    struct PKEBXB has drop {
        dummy_field: bool,
    }

    fun init(arg0: PKEBXB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PKEBXB>(arg0, 9, b"PKEBXB", b"hsjdn", b"bdndn", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0a38fe29-1d82-4c68-8ce0-f64d338e4867.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PKEBXB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PKEBXB>>(v1);
    }

    // decompiled from Move bytecode v6
}

