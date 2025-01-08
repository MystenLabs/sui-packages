module 0xc3c53d07ced7339aa4b70cd6ddf72ba84860740efecda5ebf88cfa8b4ba49310::arkaeon {
    struct ARKAEON has drop {
        dummy_field: bool,
    }

    fun init(arg0: ARKAEON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ARKAEON>(arg0, 6, b"ARKAEON", b"Arkaeon AI", b"| AI-Driven Insights and Automation | Intelligent Solutions for Data", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736358890133.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ARKAEON>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ARKAEON>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

