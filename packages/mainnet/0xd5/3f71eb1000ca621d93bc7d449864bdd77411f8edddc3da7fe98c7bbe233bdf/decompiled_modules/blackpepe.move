module 0xd53f71eb1000ca621d93bc7d449864bdd77411f8edddc3da7fe98c7bbe233bdf::blackpepe {
    struct BLACKPEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLACKPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLACKPEPE>(arg0, 6, b"BLACKPEPE", b"Black Pepe", b"Black Pepes matter.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_11_085324_0de655582a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLACKPEPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLACKPEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

