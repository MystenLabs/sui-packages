module 0x96b9393ec1b689836236b64bdec58156cdeb11b99a45a736391a16ece92d1c0::zola {
    struct ZOLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZOLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZOLA>(arg0, 6, b"ZOLA", b"The Baby Cheetah", b"The famous Baby Cheetah Zola is on SUI! Can the Zola's community grow on SUI? Join TG and find out!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/u8936948123_create_a_light_blue_style_sticker_of_cincinatti_z_e4f63684_75bb_4573_84ec_c50e832ad779_1_3753d41123.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZOLA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZOLA>>(v1);
    }

    // decompiled from Move bytecode v6
}

