module 0x691de9657d7e4c196d9d04bff7a00ee708073d24c60f76565c324d4a87307b3::flyingcat {
    struct FLYINGCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLYINGCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLYINGCAT>(arg0, 6, b"FLYINGCAT", b"Flying Cat", b"Lets fly to the be higher", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000052238_3695e9a09f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLYINGCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FLYINGCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

