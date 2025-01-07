module 0x33d4a2feda41c52956ee2f5f1a68de53e48e6aab013b61b8279e7a5fbf1839b8::popo {
    struct POPO has drop {
        dummy_field: bool,
    }

    fun init(arg0: POPO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POPO>(arg0, 6, b"POPO", b"Popo on SUI", b"Popo is a water spirit roaming the world of SUI in search of a new home.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/500x500_2_e3d47fb789.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POPO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POPO>>(v1);
    }

    // decompiled from Move bytecode v6
}

