module 0x7d85cb12db942a8721660b5a70cc78a3559012f9e2719d323ac4d36d8353f343::fnc {
    struct FNC has drop {
        dummy_field: bool,
    }

    fun init(arg0: FNC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FNC>(arg0, 9, b"FNC", b"Fincoin", b"Memecoin ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8538af25-e14c-4c0d-a5d9-f6d690f2d05e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FNC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FNC>>(v1);
    }

    // decompiled from Move bytecode v6
}

