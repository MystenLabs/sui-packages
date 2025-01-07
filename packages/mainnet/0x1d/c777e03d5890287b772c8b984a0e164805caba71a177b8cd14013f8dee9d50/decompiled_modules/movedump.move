module 0x1dc777e03d5890287b772c8b984a0e164805caba71a177b8cd14013f8dee9d50::movedump {
    struct MOVEDUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOVEDUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOVEDUMP>(arg0, 6, b"MOVEDUMP", b"movedump", b"The yin yan of movepump ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/movedump_d53c40b57d_e16ec5fa8d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOVEDUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOVEDUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

