module 0x1899a59b3fdaf0d72ef12159489594a38b834215d2ed037d5eedf5ad33ffb081::bdgsn {
    struct BDGSN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BDGSN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BDGSN>(arg0, 9, b"BDGSN", b"Bedigasan", b"You future.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8fef3e43-496c-491b-9825-bd842384008b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BDGSN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BDGSN>>(v1);
    }

    // decompiled from Move bytecode v6
}

