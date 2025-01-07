module 0x6ef1a9df36439696effe41a412d396eb1924eb38bee5112188da4773c793220f::tweety {
    struct TWEETY has drop {
        dummy_field: bool,
    }

    fun init(arg0: TWEETY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TWEETY>(arg0, 6, b"TWEETY", b"SUI TWEETY", b"$Tweety The Chillest Duck on SUI! the laid-back duck who rules the water blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735755411699.29")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TWEETY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TWEETY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

