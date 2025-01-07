module 0x1d758e00857eb301e2d812d1e700ccad5e735742ba2f675c8da5541037823ed1::kaafka {
    struct KAAFKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: KAAFKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KAAFKA>(arg0, 6, b"Kaafka", b"VedicAstro", b"Atro Crypto Trading Signals and Birth Chart Readings", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731374927510.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KAAFKA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KAAFKA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

