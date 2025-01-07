module 0x33ea0709b7e178fd20189eb3da0224fcada161abb7c732ac97d5e0ede3a10065::gigalion {
    struct GIGALION has drop {
        dummy_field: bool,
    }

    fun init(arg0: GIGALION, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GIGALION>(arg0, 6, b"GigaLion", b"GigaLionSUI", b"$GIGA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Wu_FEEZ_0_F_400x400_8c7105b3fd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GIGALION>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GIGALION>>(v1);
    }

    // decompiled from Move bytecode v6
}

