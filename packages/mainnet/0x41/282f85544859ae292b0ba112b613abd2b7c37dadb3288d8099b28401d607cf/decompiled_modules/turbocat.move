module 0x41282f85544859ae292b0ba112b613abd2b7c37dadb3288d8099b28401d607cf::turbocat {
    struct TURBOCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TURBOCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TURBOCAT>(arg0, 6, b"TURBOCAT", b"TurboCat", b"$TURBOCAT on turbos", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730984682680.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TURBOCAT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TURBOCAT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

