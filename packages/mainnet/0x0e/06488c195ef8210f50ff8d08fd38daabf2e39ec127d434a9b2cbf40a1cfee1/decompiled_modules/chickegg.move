module 0xe06488c195ef8210f50ff8d08fd38daabf2e39ec127d434a9b2cbf40a1cfee1::chickegg {
    struct CHICKEGG has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHICKEGG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHICKEGG>(arg0, 6, b"CHICKEGG", b"CHICKEGGSUI", b"Welcome to ChickEgg! Join us as we sip, stroll, and explore the worldone tiny adventure at a time", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Boc5_ze_Z_400x400_a5629c4ad2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHICKEGG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHICKEGG>>(v1);
    }

    // decompiled from Move bytecode v6
}

