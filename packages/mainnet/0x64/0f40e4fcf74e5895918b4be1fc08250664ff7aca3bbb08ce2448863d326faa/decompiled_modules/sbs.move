module 0x640f40e4fcf74e5895918b4be1fc08250664ff7aca3bbb08ce2448863d326faa::sbs {
    struct SBS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBS>(arg0, 6, b"SBS", b"Sui Blue", b"Fan token of the cute and powerful mew. Join us as we burn the supply and add utility! Lets build a real community!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5524_52e5df7c1c.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SBS>>(v1);
    }

    // decompiled from Move bytecode v6
}

