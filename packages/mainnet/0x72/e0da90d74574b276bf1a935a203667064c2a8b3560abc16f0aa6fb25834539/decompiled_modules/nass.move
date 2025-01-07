module 0x72e0da90d74574b276bf1a935a203667064c2a8b3560abc16f0aa6fb25834539::nass {
    struct NASS has drop {
        dummy_field: bool,
    }

    fun init(arg0: NASS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NASS>(arg0, 9, b"NASS", b"NAS", b"Token NAS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8c14467e-29f1-4fcd-8e6f-f0b4e08a071e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NASS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NASS>>(v1);
    }

    // decompiled from Move bytecode v6
}

