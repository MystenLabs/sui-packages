module 0x446431adb3b1fcef4c473eeaba4da7a5968f321e1baadf996f256f5105dab9c::suixin {
    struct SUIXIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIXIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIXIN>(arg0, 6, b"SUIXIN", b"Suixin", b"THE CHINESE CAT FISH LAUNCHING ON MOVEPUMP", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suixin_removebg_preview_b004efd378.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIXIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIXIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

