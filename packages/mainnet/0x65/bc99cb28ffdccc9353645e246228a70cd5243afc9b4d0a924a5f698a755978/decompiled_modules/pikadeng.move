module 0x65bc99cb28ffdccc9353645e246228a70cd5243afc9b4d0a924a5f698a755978::pikadeng {
    struct PIKADENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIKADENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIKADENG>(arg0, 6, b"PIKADENG", b"PIKA MOODENG", b"Picture a hippo with Pikachu's facea blend of the hippo's hefty, barrel-shaped body with Pikachu's cute, bright yellow face, red cheeks, and pointy ears. This unique creature would have the playful, electrifying charm of Pikachu combined with the imposing, lovable presence of a hippo. Quite the extraordinary combo, don't you think? ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0dedab41_9906_4652_848d_7fbf26474212_a2b4c36233.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIKADENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PIKADENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

