module 0x8f88db3ba7bcccdc08e6bf36b02c109f1bc3adfce26e34817d416a855d2ebe57::lucto {
    struct LUCTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUCTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LUCTO>(arg0, 6, b"LUCTO", b"Lucto on SUi", b"reee", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Y0t_C3_CBF_400x400_a618aff077.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUCTO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LUCTO>>(v1);
    }

    // decompiled from Move bytecode v6
}

