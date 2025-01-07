module 0x81fa75e792c934630ce494b638a21b66af46428f28e7538890091c309904554e::squirfler {
    struct SQUIRFLER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SQUIRFLER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SQUIRFLER>(arg0, 6, b"SQUIRFLER", b"SQUIRFLER on SUI", b"SQUIRFLER is the exciting new token inspired by the beloved water Pokmon, launched on the innovative SUI network. With a focus on community and sustainability, SQUIRFLER aims to bring the fun of the Pokmon universe into the world of cryptocurrency. Join us on this unique adventure, where every transaction is a step toward a more exciting and aquatic future. Ride the wave with SQUIRFLER and be part of our journey!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_49c3259b67.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SQUIRFLER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SQUIRFLER>>(v1);
    }

    // decompiled from Move bytecode v6
}

