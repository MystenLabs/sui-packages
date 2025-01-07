module 0xb0a2030adc8799658dab526897e4e792fc73e686f8ac4bbd1176fe760fc9c9d8::orco {
    struct ORCO has drop {
        dummy_field: bool,
    }

    fun init(arg0: ORCO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ORCO>(arg0, 6, b"ORCO", b"ORCOSUI", b"Our mission is to help endangered species and clean the ocean, one step at a time!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/uszzmi_M0_400x400_974fc9a820.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ORCO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ORCO>>(v1);
    }

    // decompiled from Move bytecode v6
}

