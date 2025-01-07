module 0x6a3b5df96f86ff183a3604b67e8e5e79415bd8ca192c514a72d06685bec048a6::suishii {
    struct SUISHII has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISHII, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISHII>(arg0, 6, b"Suishii", b"Suishi", x"7375692061706573206172652068756e6772792e0a0a24737569736869", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3984_bb3e5c5209.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISHII>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISHII>>(v1);
    }

    // decompiled from Move bytecode v6
}

