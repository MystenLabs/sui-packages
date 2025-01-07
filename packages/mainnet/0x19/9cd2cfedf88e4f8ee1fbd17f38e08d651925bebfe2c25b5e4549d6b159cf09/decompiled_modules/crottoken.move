module 0x199cd2cfedf88e4f8ee1fbd17f38e08d651925bebfe2c25b5e4549d6b159cf09::crottoken {
    struct CROTTOKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: CROTTOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CROTTOKEN>(arg0, 9, b"CROTTOKEN", b"Crot", b"Meme token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/40944e2b-14e5-4488-9713-523396d178c8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CROTTOKEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CROTTOKEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

