module 0x837ec1775840b589358a2cc1fe69d4fb4aeb03da34d95f8952ea566a9d864177::suinami {
    struct SUINAMI has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUINAMI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SUINAMI>>(0x2::coin::mint<SUINAMI>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: SUINAMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINAMI>(arg0, 6, b"SUINAMI", b"NAMI", b"RIDE THAT WAVE BABY", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUINAMI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINAMI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

