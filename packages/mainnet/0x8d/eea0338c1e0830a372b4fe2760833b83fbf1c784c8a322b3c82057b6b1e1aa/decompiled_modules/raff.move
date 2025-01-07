module 0x8deea0338c1e0830a372b4fe2760833b83fbf1c784c8a322b3c82057b6b1e1aa::raff {
    struct RAFF has drop {
        dummy_field: bool,
    }

    fun init(arg0: RAFF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RAFF>(arg0, 6, b"RAFF", b"RAFF the Giraffe", b"Raff wont stop grow his neck keeps rising to the moon above all other", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/I1_Ezv5_QW_400x400_02f8bf4003.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RAFF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RAFF>>(v1);
    }

    // decompiled from Move bytecode v6
}

