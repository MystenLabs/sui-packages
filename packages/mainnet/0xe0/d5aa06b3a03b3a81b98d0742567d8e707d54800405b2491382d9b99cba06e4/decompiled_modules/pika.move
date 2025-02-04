module 0xe0d5aa06b3a03b3a81b98d0742567d8e707d54800405b2491382d9b99cba06e4::pika {
    struct PIKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIKA>(arg0, 6, b"PIKA", b"Pikachu", b"Welcome to the Pokemon World ! I*am Pikachu !!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/6663_E928_93_EE_4_E14_8_ED_8_39_FB_08265_D54_92fa471b25.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIKA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PIKA>>(v1);
    }

    // decompiled from Move bytecode v6
}

