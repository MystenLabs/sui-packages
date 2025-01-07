module 0x1f8a9dac71351a3f73f54ee28ed4dc60a2190ae026a286b66635f73fe89216a6::unisui {
    struct UNISUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: UNISUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UNISUI>(arg0, 6, b"UNISUI", b"Suinicorn", b"Is a Fish? is a Unicorn? No it's the Suinicorn!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_27_16_55_20_a3e4edc8b9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UNISUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<UNISUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

