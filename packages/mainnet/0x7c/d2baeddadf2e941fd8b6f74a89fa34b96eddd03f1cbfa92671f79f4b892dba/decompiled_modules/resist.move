module 0x7cd2baeddadf2e941fd8b6f74a89fa34b96eddd03f1cbfa92671f79f4b892dba::resist {
    struct RESIST has drop {
        dummy_field: bool,
    }

    fun init(arg0: RESIST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RESIST>(arg0, 6, b"RESIST", b"Resist AI", b"$RESIST symbolizes the refusal to surrender our uniqueness to the tidal wave of AI technology.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1733626810688.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RESIST>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RESIST>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

