module 0x9670f66e10d35934559bc1d54515cedd6bc9baed01e8c99447f99887e8c28250::nscf {
    struct NSCF has drop {
        dummy_field: bool,
    }

    fun init(arg0: NSCF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NSCF>(arg0, 6, b"NSCF", b"Non Smoking Crab Fish", b"No socials meta, join the culture!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0394_142c44a08e.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NSCF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NSCF>>(v1);
    }

    // decompiled from Move bytecode v6
}

