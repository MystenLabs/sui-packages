module 0x108a1e111952d839ffd54ad604477ea73ad6d7b3e324887fa726a39fbaa2f4ff::batsui {
    struct BATSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BATSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BATSUI>(arg0, 6, b"BATSUI", b"BatSUI", b"The newmeta is coming $BATSUI is going to pump", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1728666538221_91d428411e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BATSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BATSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

