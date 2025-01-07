module 0x1ef58348aeaeeddcaf455e6a523193db1f4f0445e03777d4bc5760f5b42e0148::bots {
    struct BOTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOTS>(arg0, 6, b"BOTS", b"Psycho Bots", x"546865204f6666696369616c2050737963686f20426f7473204d656d6520546f6b656e206f6e2074686520537569204e6574776f726b2e200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/botzsz_2f212f5772.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOTS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOTS>>(v1);
    }

    // decompiled from Move bytecode v6
}

