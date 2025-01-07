module 0xae1780149c38655fa3084a4a7de8faf84717fba16d635decaaafd0fd3b349c2::gem {
    struct GEM has drop {
        dummy_field: bool,
    }

    fun init(arg0: GEM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GEM>(arg0, 6, b"GEM", b"Gamer", b"Make Games Great Again!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/gamer_GO_70cc994b25.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GEM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GEM>>(v1);
    }

    // decompiled from Move bytecode v6
}

