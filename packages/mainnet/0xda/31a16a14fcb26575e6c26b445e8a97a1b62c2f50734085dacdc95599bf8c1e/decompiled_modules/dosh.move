module 0xda31a16a14fcb26575e6c26b445e8a97a1b62c2f50734085dacdc95599bf8c1e::dosh {
    struct DOSH has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOSH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOSH>(arg0, 6, b"DOSH", b"Dooshes", b"As Dooshes ourselves, we understand that many of you, like us, have been exiled from our families and friend groups for a variety of reasons. Whether you banged your buddies mom, bullied that one kid, leaked your sisters nudes, or ran over the neighborhood grandma's mailbox in your PT Cruiser, we're here for you.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://movepump.xyz/uploads/pfp_48f6a8a119.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOSH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOSH>>(v1);
    }

    // decompiled from Move bytecode v6
}

