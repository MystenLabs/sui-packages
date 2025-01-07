module 0x46686d41432c57faf2a97bd7daeabf61d7eaeeb01a7d27c47b7d397e384f975c::ricky {
    struct RICKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: RICKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RICKY>(arg0, 9, b"RICKY", b"Ricky ko", b"Rickyko", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/70878350-8e89-46f2-8817-076600804406.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RICKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RICKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

