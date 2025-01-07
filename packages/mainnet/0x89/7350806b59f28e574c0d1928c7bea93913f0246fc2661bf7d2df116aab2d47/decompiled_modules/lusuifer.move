module 0x897350806b59f28e574c0d1928c7bea93913f0246fc2661bf7d2df116aab2d47::lusuifer {
    struct LUSUIFER has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUSUIFER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LUSUIFER>(arg0, 6, b"LUSUIFER", b"LuSUIfer", b"LUSUIFER is the devilish overlord of the SUI Network, bringing fire, flair, and a bit of chaos to the blockchain. With every deal, he's tempting you to dive deeper into his world because who wouldn't want a little mischief with their crypto?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_04_21_03_09_6d8b1bc202.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUSUIFER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LUSUIFER>>(v1);
    }

    // decompiled from Move bytecode v6
}

