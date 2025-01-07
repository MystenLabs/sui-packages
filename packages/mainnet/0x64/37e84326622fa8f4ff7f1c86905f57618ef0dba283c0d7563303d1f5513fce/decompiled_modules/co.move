module 0x6437e84326622fa8f4ff7f1c86905f57618ef0dba283c0d7563303d1f5513fce::co {
    struct CO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CO>(arg0, 9, b"CO", x"434fe0a7a8", b"its degital currency, i made it because  i wanna change  tha system", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8bfef312-3f20-4034-99b0-ab1a93cadf23.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CO>>(v1);
    }

    // decompiled from Move bytecode v6
}

