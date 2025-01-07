module 0x8a5e7aa1fed01dcc5cc4430aa67a2f71c4e778c4a415fe4636716e63572fd5b1::taxi {
    struct TAXI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TAXI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TAXI>(arg0, 6, b"TAXI", b"Ape Taxi", b"$TAXI - Welcome APE TAXI - If you don't have money for a ride ...dont offer me a blow\\*ob... banana is totally fine...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pfp_35b455788f.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TAXI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TAXI>>(v1);
    }

    // decompiled from Move bytecode v6
}

