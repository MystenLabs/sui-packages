module 0xa93846b65e621b906a1e539066254021bd09ce2ec28d073dc7e574c8f405735::catdeng {
    struct CATDENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATDENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATDENG>(arg0, 6, b"CATDENG", b"Catdeng", b"Meet Catdeng, the first hippocat on Sui!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_6323427101352508118_y_8d18fcc35e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATDENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATDENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

