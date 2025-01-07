module 0x10f5222c3cb86491ac1aeb3a7b28e394e430307fc3548e07b1e4558671d77f9e::nit {
    struct NIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: NIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NIT>(arg0, 9, b"NIT", b"N.I.T", b"Now, I Think", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4343ff1b-e095-4a6c-9fa4-0d798b00a486.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NIT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NIT>>(v1);
    }

    // decompiled from Move bytecode v6
}

