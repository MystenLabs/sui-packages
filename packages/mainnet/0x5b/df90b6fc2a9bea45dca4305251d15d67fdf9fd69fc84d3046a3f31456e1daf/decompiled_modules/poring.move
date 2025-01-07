module 0x5bdf90b6fc2a9bea45dca4305251d15d67fdf9fd69fc84d3046a3f31456e1daf::poring {
    struct PORING has drop {
        dummy_field: bool,
    }

    fun init(arg0: PORING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PORING>(arg0, 6, b"PORING", b"PORINGSUI", b"$PORING - The first memcoin on $SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/3ff4b21e_0f8e_43b8_95df_71aba21b766b_88652c9c8e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PORING>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PORING>>(v1);
    }

    // decompiled from Move bytecode v6
}

