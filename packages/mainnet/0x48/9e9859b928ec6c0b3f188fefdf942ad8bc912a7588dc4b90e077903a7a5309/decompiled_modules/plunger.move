module 0x489e9859b928ec6c0b3f188fefdf942ad8bc912a7588dc4b90e077903a7a5309::plunger {
    struct PLUNGER has drop {
        dummy_field: bool,
    }

    fun init(arg0: PLUNGER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PLUNGER>(arg0, 6, b"PLUNGER", b"PLUNGER DUST", b"The memecoin you needed but didnt know it yet. Dont flush your dreams just yet, $PLUNGER is here to unclog your portfolio! Someone missed $TOILET? Chill, well reach him soon ;)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/posible_e7426525c6.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PLUNGER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PLUNGER>>(v1);
    }

    // decompiled from Move bytecode v6
}

