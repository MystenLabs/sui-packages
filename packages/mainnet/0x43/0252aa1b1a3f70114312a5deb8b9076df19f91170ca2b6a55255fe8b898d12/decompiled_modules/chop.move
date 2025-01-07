module 0x430252aa1b1a3f70114312a5deb8b9076df19f91170ca2b6a55255fe8b898d12::chop {
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

