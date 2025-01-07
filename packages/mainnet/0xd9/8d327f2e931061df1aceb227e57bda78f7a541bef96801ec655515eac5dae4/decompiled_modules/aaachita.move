module 0xd98d327f2e931061df1aceb227e57bda78f7a541bef96801ec655515eac5dae4::aaachita {
    struct AAACHITA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAACHITA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAACHITA>(arg0, 6, b"aaaChita", b"aaaCHITA", b"Cant stop wont stop talking about sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_2439_57748b88c5.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAACHITA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAACHITA>>(v1);
    }

    // decompiled from Move bytecode v6
}

