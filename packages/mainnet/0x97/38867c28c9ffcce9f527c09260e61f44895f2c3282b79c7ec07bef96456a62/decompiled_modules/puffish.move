module 0x9738867c28c9ffcce9f527c09260e61f44895f2c3282b79c7ec07bef96456a62::puffish {
    struct PUFFISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUFFISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUFFISH>(arg0, 6, b"PUFFISH", b"Puffish", b"Puf puf pufferfish", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1079_66835c8572.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUFFISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUFFISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

