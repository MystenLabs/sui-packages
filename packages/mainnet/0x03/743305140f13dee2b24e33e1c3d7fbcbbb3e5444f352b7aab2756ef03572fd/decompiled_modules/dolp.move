module 0x3743305140f13dee2b24e33e1c3d7fbcbbb3e5444f352b7aab2756ef03572fd::dolp {
    struct DOLP has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOLP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOLP>(arg0, 6, b"DOLP", b"DOLPSUIN", b"THE ONLY DOLPHIN ON THE SUIN Dolp is the best aquatic animal on SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0a_Ed5c_Gt_400x400_5417a6f97f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOLP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOLP>>(v1);
    }

    // decompiled from Move bytecode v6
}

