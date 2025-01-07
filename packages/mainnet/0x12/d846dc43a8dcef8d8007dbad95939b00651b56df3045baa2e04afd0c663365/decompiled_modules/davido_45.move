module 0x12d846dc43a8dcef8d8007dbad95939b00651b56df3045baa2e04afd0c663365::davido_45 {
    struct DAVIDO_45 has drop {
        dummy_field: bool,
    }

    fun init(arg0: DAVIDO_45, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DAVIDO_45>(arg0, 9, b"DAVIDO_45", b"Davido", b"For fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/191de6bb-0c2e-4cf9-a2ec-6f772d7733ca.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DAVIDO_45>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DAVIDO_45>>(v1);
    }

    // decompiled from Move bytecode v6
}

