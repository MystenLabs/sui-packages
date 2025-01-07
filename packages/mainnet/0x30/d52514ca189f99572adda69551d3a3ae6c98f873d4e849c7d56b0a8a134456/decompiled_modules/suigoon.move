module 0x30d52514ca189f99572adda69551d3a3ae6c98f873d4e849c7d56b0a8a134456::suigoon {
    struct SUIGOON has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIGOON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIGOON>(arg0, 6, b"SUIGOON", b"Suigoon", b"The most memeable memecoin on SUI Blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_6325601196617876484_x_f78367a1a0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIGOON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIGOON>>(v1);
    }

    // decompiled from Move bytecode v6
}

