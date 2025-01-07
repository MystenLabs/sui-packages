module 0x785dab9ba373eedf33dda976548a6222500a06a4cb75da9f7a96e9582ddfb2fb::dhands {
    struct DHANDS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DHANDS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DHANDS>(arg0, 6, b"DHANDS", b"Diamonds Hands Sui", b"We Only Accept Diamond Hands Sui, no paper hands.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730961268531.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DHANDS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DHANDS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

