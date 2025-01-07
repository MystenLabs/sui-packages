module 0x960887973de32f6a6411a79ceca9ae1f8f4ec69ce53d6d53cae0c4cd06fba2ed::ada {
    struct ADA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ADA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ADA>(arg0, 6, b"ADA", b"Adansonia digitata", b"The baobab tree, a towering giant tree used internally to store vast amounts of water resources.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/people_8559416_1280_3a646d7164.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ADA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ADA>>(v1);
    }

    // decompiled from Move bytecode v6
}

