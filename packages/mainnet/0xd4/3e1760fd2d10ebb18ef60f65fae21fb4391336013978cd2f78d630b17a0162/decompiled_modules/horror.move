module 0xd43e1760fd2d10ebb18ef60f65fae21fb4391336013978cd2f78d630b17a0162::horror {
    struct HORROR has drop {
        dummy_field: bool,
    }

    fun init(arg0: HORROR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HORROR>(arg0, 6, b"HORROR", b"THE SUI HORROR SHOW", b"This token will terrorize the blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/STRANGEHARVEST_STILL_2_cd6ea12459.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HORROR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HORROR>>(v1);
    }

    // decompiled from Move bytecode v6
}

