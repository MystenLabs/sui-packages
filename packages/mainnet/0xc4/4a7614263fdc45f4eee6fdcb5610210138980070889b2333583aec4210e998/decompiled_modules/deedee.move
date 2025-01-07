module 0xc44a7614263fdc45f4eee6fdcb5610210138980070889b2333583aec4210e998::deedee {
    struct DEEDEE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEEDEE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEEDEE>(arg0, 6, b"DEEDEE", b"DeeDee", b"DeeDee The big dick on SUi.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_15_11_14_30_8d2deeb300.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEEDEE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DEEDEE>>(v1);
    }

    // decompiled from Move bytecode v6
}

