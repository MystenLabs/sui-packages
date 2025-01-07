module 0x7019bfde93d37b9af25dc118e4b4358f3ceeda815d7196f959e64634f8c1515d::ame {
    struct AME has drop {
        dummy_field: bool,
    }

    fun init(arg0: AME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AME>(arg0, 6, b"AME", b"AMESUI", x"53756920636f6c6c65637465642066726f6d20616d692064726f70730a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/cartoon_rain_icon_png_87ad299bfa.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AME>>(v1);
    }

    // decompiled from Move bytecode v6
}

