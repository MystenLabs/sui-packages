module 0xf1744c3695de4d45a1bb6b14d5023309d6036f8e52301270a5c886fc705b4059::desavong {
    struct DESAVONG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DESAVONG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DESAVONG>(arg0, 6, b"DESAVONG", b"des avongerz", b"We kame to chnge da spayce foreverz. WII hve been prepared evertinn carefolly in order to pampa hard. Doz fokin callers R bakin' us up so ket rady to flyy mtfk.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/main_b1d0676e02.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DESAVONG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DESAVONG>>(v1);
    }

    // decompiled from Move bytecode v6
}

