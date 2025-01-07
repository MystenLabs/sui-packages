module 0x8173f6edc0e99492c7989c5c7117c1043980b07fa96623322e6a8e10ff8b637e::maba {
    struct MABA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MABA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MABA>(arg0, 6, b"MABA", b"Make America Based Again!", b"Lat's go Make America Based Again!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000008550_85d9bf4439.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MABA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MABA>>(v1);
    }

    // decompiled from Move bytecode v6
}

