module 0x71ac926071cdc6014366d9221f2d5fe61826574204d2d3535ca632e77895767f::squirt {
    struct SQUIRT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SQUIRT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SQUIRT>(arg0, 6, b"SQUIRT", b"$SQUIRT", b"$SQUIRT Is a social token feeding on other memes and news storys. $SQUIRT and publish is our motto!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/squirt_b7c6edeeb1.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SQUIRT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SQUIRT>>(v1);
    }

    // decompiled from Move bytecode v6
}

