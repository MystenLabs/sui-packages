module 0x6530b3412db1f596d5791370be82445d06bae228702f247767054ed13ad22cd4::bsuip {
    struct BSUIP has drop {
        dummy_field: bool,
    }

    fun init(arg0: BSUIP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BSUIP>(arg0, 6, b"BSUIP", b"BabySuiPlop", b"The baby of the Plop Sui token.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/baby_water_drop_cartoon_character_with_pacifier_free_vector_2787886810.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BSUIP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BSUIP>>(v1);
    }

    // decompiled from Move bytecode v6
}

