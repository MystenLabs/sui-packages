module 0x6d892a1522884d20e7044dd0214c7fd67574766e28f67bcb55e2457e709cc246::educk {
    struct EDUCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: EDUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EDUCK>(arg0, 9, b"EDUCK", b"Eggduck", b"Token meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4481b823-4633-4009-a57f-6aceeb7916ff.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EDUCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EDUCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

