module 0xa725aaff39b6a966b46a3c1e12a2cdd57c96c7242376bc07587243eebdc85055::elun {
    struct ELUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ELUN>(arg0, 6, b"ELUN", b"FURST BUDDY ELUN", b"Thus us the furst buddy Elun on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000009416_e0489b57d6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELUN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ELUN>>(v1);
    }

    // decompiled from Move bytecode v6
}

