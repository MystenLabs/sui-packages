module 0xf50e3f53ad957a825fb47da9e0c8174d600213778f10fb4d73388a688875750d::mm {
    struct MM has drop {
        dummy_field: bool,
    }

    fun init(arg0: MM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MM>(arg0, 6, b"Mm", b"Mumi", b"The moons favorite puppy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a_a_a_a_a_a_a_a_a_a_a_a_a_a_a_a_a_a_a_a_a_a_a_a_a_a_a1c84cd13d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MM>>(v1);
    }

    // decompiled from Move bytecode v6
}

