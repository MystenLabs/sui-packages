module 0xfdb971f398fd6dd0d45717c92e2170789602c63cf7a46a4173c515dc0190731::dguaubg {
    struct DGUAUBG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DGUAUBG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DGUAUBG>(arg0, 9, b"DGUAUBG", b"Dragon3388", b"Gm good products", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ea240c70-cfdf-4d0d-b92b-1e89880401af.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DGUAUBG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DGUAUBG>>(v1);
    }

    // decompiled from Move bytecode v6
}

