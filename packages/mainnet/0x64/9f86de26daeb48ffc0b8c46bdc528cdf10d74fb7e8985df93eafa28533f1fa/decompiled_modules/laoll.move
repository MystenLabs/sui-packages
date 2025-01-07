module 0x649f86de26daeb48ffc0b8c46bdc528cdf10d74fb7e8985df93eafa28533f1fa::laoll {
    struct LAOLL has drop {
        dummy_field: bool,
    }

    fun init(arg0: LAOLL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LAOLL>(arg0, 9, b"LAOLL", b"LALOL", b"THAT THIS DAY YOUR", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d13b7cc3-f098-426a-9b10-3055f0230573.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LAOLL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LAOLL>>(v1);
    }

    // decompiled from Move bytecode v6
}

