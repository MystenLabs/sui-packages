module 0xf7ff8fb6c760ab2ca9b41c3fddc1f897ecba6f23b53fa48399a90c896f0c4f93::dosh {
    struct DOSH has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOSH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOSH>(arg0, 6, b"DOSH", b"Dooshes", b"As Dooshes ourselves, we understand that many of you, like us, have been exiled from our families and friend groups for a variety of reasons. Whether you banged your buddies mom, bullied that one kid, leaked your sisters nudes, or ran over the neighborhood grandma's mailbox in your PT Cruiser, we're here for you. | Website: https://brokeagain.fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pfp_8d3f890c00.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOSH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOSH>>(v1);
    }

    // decompiled from Move bytecode v6
}

