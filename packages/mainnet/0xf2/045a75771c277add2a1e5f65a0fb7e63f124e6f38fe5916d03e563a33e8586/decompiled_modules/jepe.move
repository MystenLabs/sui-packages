module 0xf2045a75771c277add2a1e5f65a0fb7e63f124e6f38fe5916d03e563a33e8586::jepe {
    struct JEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: JEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JEPE>(arg0, 6, b"JEPE", b"JepeOnSui", b"the most memeable jellyfish on the internet", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241010_160819_d3eaf7183d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JEPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

