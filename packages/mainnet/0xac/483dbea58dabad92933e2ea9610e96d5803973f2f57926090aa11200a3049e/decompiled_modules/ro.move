module 0xac483dbea58dabad92933e2ea9610e96d5803973f2f57926090aa11200a3049e::ro {
    struct RO has drop {
        dummy_field: bool,
    }

    fun init(arg0: RO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RO>(arg0, 6, b"Ro", b"Robotaxi", b"Tesla's robotaxi service is part of Elon Musk's vision for autonomous ride-hailing. The concept involves using Tesla's electric vehicles (EVs) equipped with full self-driving (FSD) capabilities to operate as autonomous taxis.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1728131427232_265f6f53c1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RO>>(v1);
    }

    // decompiled from Move bytecode v6
}

