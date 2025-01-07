module 0xd79c4de2df7669ffe3c24552d78abdeed3917502a8dbb3d83dcafa643b0485c5::les {
    struct LES has drop {
        dummy_field: bool,
    }

    fun init(arg0: LES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LES>(arg0, 6, b"LES", b"Lessons", b"Lessons in life. Pure meme, no TG, X and Web links for shilling. Just panting for fun a few SUI for trading and having fun or just hodl.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_2672_ee5a95692e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LES>>(v1);
    }

    // decompiled from Move bytecode v6
}

