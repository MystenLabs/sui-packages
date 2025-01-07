module 0xd536e56b30ff71775716881b05e5413f6aa4ea789042fe479ccefb79369c0d07::offside {
    struct OFFSIDE has drop {
        dummy_field: bool,
    }

    fun init(arg0: OFFSIDE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OFFSIDE>(arg0, 6, b"OFFSIDE", b"Offside on Sui", b"Don't be $OFFSIDE bruv, like all the time. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000032766_527ef5d092.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OFFSIDE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OFFSIDE>>(v1);
    }

    // decompiled from Move bytecode v6
}

