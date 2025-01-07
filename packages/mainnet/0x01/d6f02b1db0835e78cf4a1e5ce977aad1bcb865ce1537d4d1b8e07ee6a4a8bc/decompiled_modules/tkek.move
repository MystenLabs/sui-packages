module 0x1d6f02b1db0835e78cf4a1e5ce977aad1bcb865ce1537d4d1b8e07ee6a4a8bc::tkek {
    struct TKEK has drop {
        dummy_field: bool,
    }

    fun init(arg0: TKEK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TKEK>(arg0, 6, b"TKEK", b"TOPKEK SUI", b"Memecoin at fair pricing. KEK!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000004469_2721a7ce36.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TKEK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TKEK>>(v1);
    }

    // decompiled from Move bytecode v6
}

