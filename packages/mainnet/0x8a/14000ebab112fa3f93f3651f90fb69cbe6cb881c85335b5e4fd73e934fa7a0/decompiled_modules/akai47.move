module 0x8a14000ebab112fa3f93f3651f90fb69cbe6cb881c85335b5e4fd73e934fa7a0::akai47 {
    struct AKAI47 has drop {
        dummy_field: bool,
    }

    fun init(arg0: AKAI47, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AKAI47>(arg0, 6, b"AKAI47", b"AKAI", b"AKAI is an AI Agent that helps you explore deep into the global AI technology scene!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://akasui-statics.sgp1.cdn.digitaloceanspaces.com/images/a13e2471-fcf4-4878-a1f5-4386dcd4d631.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AKAI47>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AKAI47>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

