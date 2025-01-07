module 0x6112ec5ececab46949580f4c77a82302611eb05c3de14c8b99cca07f482f1ccb::avatard {
    struct AVATARD has drop {
        dummy_field: bool,
    }

    fun init(arg0: AVATARD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AVATARD>(arg0, 6, b"AVATARD", b"Avatard SUI", b"avatard 3 is coming. https://t.me/AvatardSUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/G_Zs_SQVUW_4_A0_U5zs_acc213cb7a.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AVATARD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AVATARD>>(v1);
    }

    // decompiled from Move bytecode v6
}

