module 0xb5923c27785eeddd0060b5c5d3c0d4ad84cfba0ac6d3d518f9fc33dcbe117c54::pepeye {
    struct PEPEYE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPEYE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPEYE>(arg0, 6, b"PEPEYE", b"PEPEYE SUI", b"KUSH FARM", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/d42a52b9cbf1f41ebdd04b998cccc878_1_57b48532da.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPEYE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEPEYE>>(v1);
    }

    // decompiled from Move bytecode v6
}

