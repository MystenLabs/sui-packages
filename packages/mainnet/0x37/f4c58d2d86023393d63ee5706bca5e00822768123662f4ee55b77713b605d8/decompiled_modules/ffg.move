module 0x37f4c58d2d86023393d63ee5706bca5e00822768123662f4ee55b77713b605d8::ffg {
    struct FFG has drop {
        dummy_field: bool,
    }

    fun init(arg0: FFG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FFG>(arg0, 9, b"FFG", b"Gt", b"Gggh", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/bafb4511-e745-41be-acd9-a1ae68809f05.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FFG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FFG>>(v1);
    }

    // decompiled from Move bytecode v6
}

