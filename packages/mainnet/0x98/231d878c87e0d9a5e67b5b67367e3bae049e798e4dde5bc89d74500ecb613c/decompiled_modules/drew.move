module 0x98231d878c87e0d9a5e67b5b67367e3bae049e798e4dde5bc89d74500ecb613c::drew {
    struct DREW has drop {
        dummy_field: bool,
    }

    fun init(arg0: DREW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DREW>(arg0, 6, b"DREW", b"DREW THE CAT", x"536f6d65206f662075732063616d6520666f7220746865206172742c206d6f7374206f66207573207374617965642062656361757365206f662069742e200a244452455720697320666f72207468652070656f706c65", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2e_ce18a0a182.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DREW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DREW>>(v1);
    }

    // decompiled from Move bytecode v6
}

