module 0x445d8faccc60d50f8fa34f37755a17af93d50f8cfdabfc771aa48e7ac7a3046::cbrett {
    struct CBRETT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CBRETT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CBRETT>(arg0, 6, b"CBRETT", b"Chill Brett", b"Brett", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732892522246.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CBRETT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CBRETT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

