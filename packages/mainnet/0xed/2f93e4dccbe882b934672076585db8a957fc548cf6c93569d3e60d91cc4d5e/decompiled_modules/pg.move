module 0xed2f93e4dccbe882b934672076585db8a957fc548cf6c93569d3e60d91cc4d5e::pg {
    struct PG has drop {
        dummy_field: bool,
    }

    fun init(arg0: PG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PG>(arg0, 9, b"PG", b"Paragame", b"Paragame asia", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/aa4a651a-8f02-4b35-a5da-e847a1c5c76f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PG>>(v1);
    }

    // decompiled from Move bytecode v6
}

