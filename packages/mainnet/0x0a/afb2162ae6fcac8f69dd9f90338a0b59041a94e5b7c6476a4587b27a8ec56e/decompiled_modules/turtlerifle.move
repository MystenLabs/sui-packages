module 0xaafb2162ae6fcac8f69dd9f90338a0b59041a94e5b7c6476a4587b27a8ec56e::turtlerifle {
    struct TURTLERIFLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TURTLERIFLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TURTLERIFLE>(arg0, 6, b"TURTLERIFLE", b"Turtle Rifle", b"TURTLERIFLE is slow but packs a punch! Armed with a rifle on its back, this turtle isn't here to play around. Dont underestimate the turtle with firepower!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PP_1_20_896f70e202.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TURTLERIFLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TURTLERIFLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

