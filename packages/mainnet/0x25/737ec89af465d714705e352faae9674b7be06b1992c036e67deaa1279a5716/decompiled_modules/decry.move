module 0x25737ec89af465d714705e352faae9674b7be06b1992c036e67deaa1279a5716::decry {
    struct DECRY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DECRY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DECRY>(arg0, 9, b"DECRY", b"De Cryp", b"Community token ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8b927f9f-b162-49fc-b9a6-4f89b8afc478.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DECRY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DECRY>>(v1);
    }

    // decompiled from Move bytecode v6
}

