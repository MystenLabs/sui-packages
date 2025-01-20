module 0x754502762bc4cb98baeea44aa81081b7270dfe523eb59d4e32f3753513b93907::potus {
    struct POTUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: POTUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POTUS>(arg0, 6, b"POTUS", b"President Donald J.Trump", b"The Return of the King", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_8831_5f0821eb0b.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POTUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POTUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

