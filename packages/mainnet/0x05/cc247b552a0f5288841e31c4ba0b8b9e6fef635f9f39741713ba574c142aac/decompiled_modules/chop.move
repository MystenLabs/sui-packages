module 0x5cc247b552a0f5288841e31c4ba0b8b9e6fef635f9f39741713ba574c142aac::chop {
    struct CHOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHOP>(arg0, 6, b"CHOP", b"Chop Sui", b"Chop suey is a dish of meat or fish and vegetables, typically bean sprouts, bamboo shoots, water chestnuts, onions, and mushrooms, served with rice and soy sauce. The name comes from the Chinese dialect of Guangzhou and Hong Kong, where jaahp seui literally translates to \"odds and ends\".", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/chop_suey_tattoo_wok_190e0fd8ba.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHOP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHOP>>(v1);
    }

    // decompiled from Move bytecode v6
}

