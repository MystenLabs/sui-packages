module 0xae4ef979deb9b60f4a7c1e6ecfc04be16affe69226324b2c2a5fed4580157921::dfish {
    struct DFISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: DFISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DFISH>(arg0, 6, b"DFISH", b"DIAMOND FISH", b"The DFISH token is at the forefront of innovation in the decentralized finance (DeFi) space, offering a unique blend of utility, community governance, and growth potential. Designed to empower users and foster collaboration, DFISH aims to revolutionize the way we interact with financial ecosystems.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_09_011852_854ba4a087.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DFISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DFISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

