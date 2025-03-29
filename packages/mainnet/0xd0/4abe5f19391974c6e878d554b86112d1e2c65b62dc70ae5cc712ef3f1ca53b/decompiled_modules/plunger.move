module 0xd04abe5f19391974c6e878d554b86112d1e2c65b62dc70ae5cc712ef3f1ca53b::plunger {
    struct PLUNGER has drop {
        dummy_field: bool,
    }

    fun init(arg0: PLUNGER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PLUNGER>(arg0, 6, b"PLUNGER", b"PLUNGER DUST", b"The memecoin you needed but didnt know it yet. Dont flush your dreams just yet, $PLUNGER is here to unclog your portfolio! Someone missed $TOILET? Chill, well reach him soon ;)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/posible_a86b5b86cd.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PLUNGER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PLUNGER>>(v1);
    }

    // decompiled from Move bytecode v6
}

