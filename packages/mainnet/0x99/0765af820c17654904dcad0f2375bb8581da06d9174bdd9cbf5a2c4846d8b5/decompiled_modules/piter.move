module 0x990765af820c17654904dcad0f2375bb8581da06d9174bdd9cbf5a2c4846d8b5::piter {
    struct PITER has drop {
        dummy_field: bool,
    }

    fun init(arg0: PITER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PITER>(arg0, 9, b"PITER", b"SUIDERMAN", b"I m spiderman", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://movepump.com/_next/image?url=https%3A%2F%2Fapi.movepump.com%2Fuploads%2Fspiterman_0941fb3f97.jpg&w=256&q=75")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PITER>(&mut v2, 7500000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PITER>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PITER>>(v1);
    }

    // decompiled from Move bytecode v6
}

