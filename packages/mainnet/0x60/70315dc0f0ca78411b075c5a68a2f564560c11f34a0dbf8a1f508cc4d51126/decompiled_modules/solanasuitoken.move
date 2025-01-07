module 0x6070315dc0f0ca78411b075c5a68a2f564560c11f34a0dbf8a1f508cc4d51126::solanasuitoken {
    struct SOLANASUITOKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOLANASUITOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOLANASUITOKEN>(arg0, 6, b"SOLANASUITOKEN", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SOLANASUITOKEN>>(v1);
        0x2::coin::mint_and_transfer<SOLANASUITOKEN>(&mut v2, 1000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOLANASUITOKEN>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

