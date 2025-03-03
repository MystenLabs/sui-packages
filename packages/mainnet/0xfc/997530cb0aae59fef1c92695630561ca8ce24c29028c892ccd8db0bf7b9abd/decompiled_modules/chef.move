module 0xfc997530cb0aae59fef1c92695630561ca8ce24c29028c892ccd8db0bf7b9abd::chef {
    struct CHEF has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHEF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHEF>(arg0, 6, b"CHEF", b"SuiChef", b"Cooking Up Chaos Since Day On", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suichef_48f611d01d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHEF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHEF>>(v1);
    }

    // decompiled from Move bytecode v6
}

