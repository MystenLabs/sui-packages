module 0x6d852daabfdc71e03e9755ad16471efb9e4ec181ba26f443abf581f15a0e56d5::nelly {
    struct NELLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: NELLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NELLY>(arg0, 6, b"NELLY", b"NELLY on Sui", x"416e20486f6d61676520746f20446973636f7264e2809973203430342050616765204d6173636f742c204e656c6c792074686520526f626f742048616d73746572206f6e2053756921", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731074901269.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NELLY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NELLY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

