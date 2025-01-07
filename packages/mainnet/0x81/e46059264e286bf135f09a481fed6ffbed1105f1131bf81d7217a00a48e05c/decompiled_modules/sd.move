module 0x81e46059264e286bf135f09a481fed6ffbed1105f1131bf81d7217a00a48e05c::sd {
    struct SD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SD>(arg0, 6, b"SD", b"SUI DOG", b"Best meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0029_63c1d2b0a7.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SD>>(v1);
    }

    // decompiled from Move bytecode v6
}

