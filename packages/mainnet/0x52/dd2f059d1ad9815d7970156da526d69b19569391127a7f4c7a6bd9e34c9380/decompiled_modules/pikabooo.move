module 0x52dd2f059d1ad9815d7970156da526d69b19569391127a7f4c7a6bd9e34c9380::pikabooo {
    struct PIKABOOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIKABOOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIKABOOO>(arg0, 6, b"PikaBooo", b"PikaBooo!", b"Pikachu is ready for halloween! dont be scared! Come join X and Tg in the coin description", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/9n_QQ_0iwr_400x400_379cb73dd1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIKABOOO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PIKABOOO>>(v1);
    }

    // decompiled from Move bytecode v6
}

