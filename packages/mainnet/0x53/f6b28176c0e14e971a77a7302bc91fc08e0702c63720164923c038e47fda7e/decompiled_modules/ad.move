module 0x53f6b28176c0e14e971a77a7302bc91fc08e0702c63720164923c038e47fda7e::ad {
    struct AD has drop {
        dummy_field: bool,
    }

    fun init(arg0: AD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AD>(arg0, 6, b"AD", b"ssawda", b"sss", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/3fl_B_Zb8_V_400x400_b7a17c232d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AD>>(v1);
    }

    // decompiled from Move bytecode v6
}

