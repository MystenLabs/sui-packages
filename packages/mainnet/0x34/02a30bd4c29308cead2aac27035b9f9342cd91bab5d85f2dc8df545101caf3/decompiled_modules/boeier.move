module 0x3402a30bd4c29308cead2aac27035b9f9342cd91bab5d85f2dc8df545101caf3::boeier {
    struct BOEIER has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOEIER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOEIER>(arg0, 6, b"BOEIER", b"Sui Boeier", b"The most resilient turtle on Sui - BOEIER different  the kemp's ridley sea turtles dip is real", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000009369_4bf7e79624.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOEIER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOEIER>>(v1);
    }

    // decompiled from Move bytecode v6
}

