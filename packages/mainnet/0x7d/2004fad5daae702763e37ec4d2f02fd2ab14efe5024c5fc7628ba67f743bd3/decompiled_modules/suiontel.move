module 0x7d2004fad5daae702763e37ec4d2f02fd2ab14efe5024c5fc7628ba67f743bd3::suiontel {
    struct SUIONTEL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIONTEL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIONTEL>(arg0, 6, b"SUIONTEL", b"Suiontel Coore i69", x"57656c63756d20746f205375696f6e74656c20636f6f72652046616d756c790a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Design_sem_nome_2024_10_10_T160842_303_2463bd5b21.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIONTEL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIONTEL>>(v1);
    }

    // decompiled from Move bytecode v6
}

