module 0x3574033475b1e6e766ab10b3d4e2959a23e6579241e0794e91df3e166f2cfc61::flowy {
    struct FLOWY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLOWY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLOWY>(arg0, 9, b"FLOWY", b"FlowyFinanceDog", b"Hello, I'm Flowy the flow finance dog.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://movepump.com/_next/image?url=https%3A%2F%2Fapi.movepump.com%2Fuploads%2Fspiterman_0941fb3f97.jpg&w=256&q=75")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FLOWY>(&mut v2, 500000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLOWY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FLOWY>>(v1);
    }

    // decompiled from Move bytecode v6
}

