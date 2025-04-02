module 0x8ea7c8460eefe24e9d029efdbc27242084a49bbfc5f2f7efc54dda69542ba90c::jiro {
    struct JIRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: JIRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JIRO>(arg0, 6, b"JIRO", b"JIRO ON SUI", b"JOIN JIRO ON SUI AND MAKE SOME WAVES!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_6758_03b2d3a6e2.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JIRO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JIRO>>(v1);
    }

    // decompiled from Move bytecode v6
}

