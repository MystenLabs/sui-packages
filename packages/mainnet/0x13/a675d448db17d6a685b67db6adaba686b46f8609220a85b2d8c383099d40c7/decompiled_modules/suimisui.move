module 0x13a675d448db17d6a685b67db6adaba686b46f8609220a85b2d8c383099d40c7::suimisui {
    struct SUIMISUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMISUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMISUI>(arg0, 6, b"SUIMISUI", b"SUIMI", b"Suimi is the most beautiful creature of the oceans", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/imagem_2024_10_14_232905251_62da712099.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMISUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMISUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

