module 0xaa8c9e7a25818dec2ac0401f3502e3cf92bdbb3bbafa535789b8565a6537d3::octolabs {
    struct OCTOLABS has drop {
        dummy_field: bool,
    }

    fun init(arg0: OCTOLABS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OCTOLABS>(arg0, 6, b"OCTOLABS", b"Octo Labs", b"Octo Labs ready for moon ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000031753_ee3fc6bf16.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OCTOLABS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OCTOLABS>>(v1);
    }

    // decompiled from Move bytecode v6
}

