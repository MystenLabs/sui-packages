module 0xb1720120bf8cb715e08b7d583c42980e143262413d77e90027f63d69b967210::rats {
    struct RATS has drop {
        dummy_field: bool,
    }

    fun init(arg0: RATS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RATS>(arg0, 6, b"RATS", b"Turbos Rats", b"Hi Rats", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730949759800.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RATS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RATS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

