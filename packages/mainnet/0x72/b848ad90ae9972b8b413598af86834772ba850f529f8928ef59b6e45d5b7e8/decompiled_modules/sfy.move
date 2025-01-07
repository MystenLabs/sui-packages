module 0x72b848ad90ae9972b8b413598af86834772ba850f529f8928ef59b6e45d5b7e8::sfy {
    struct SFY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SFY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SFY>(arg0, 6, b"SFY", b"SUI FLUFFY", b"$FLUFFY CTO GO GO GOOO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/flufy_e9f760d254.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SFY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SFY>>(v1);
    }

    // decompiled from Move bytecode v6
}

