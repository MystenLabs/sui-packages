module 0x2da8b2fa23560249f8c4217c66ed10e2d039995702c64e3bbaafc6c5c7ef8918::zorp {
    struct ZORP has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZORP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZORP>(arg0, 6, b"ZORP", b"ZORP on Sui Ocean", b"The friendly alien from planet Solana looking for a friends in Sui ocean.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732074300567.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZORP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZORP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

