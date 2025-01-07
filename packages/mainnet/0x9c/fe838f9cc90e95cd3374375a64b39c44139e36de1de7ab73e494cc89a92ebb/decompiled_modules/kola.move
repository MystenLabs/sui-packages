module 0x9cfe838f9cc90e95cd3374375a64b39c44139e36de1de7ab73e494cc89a92ebb::kola {
    struct KOLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: KOLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KOLA>(arg0, 6, b"KOLA", b"KOASUI", b"First KOASUI on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_01_1_1396x1536_d3e7fb4bbe.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KOLA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KOLA>>(v1);
    }

    // decompiled from Move bytecode v6
}

