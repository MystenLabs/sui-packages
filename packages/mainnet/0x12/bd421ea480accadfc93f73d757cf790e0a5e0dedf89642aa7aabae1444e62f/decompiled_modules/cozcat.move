module 0x12bd421ea480accadfc93f73d757cf790e0a5e0dedf89642aa7aabae1444e62f::cozcat {
    struct COZCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: COZCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COZCAT>(arg0, 6, b"COZCAT", b"COZCAT ART", b"THE BEST ART COIN ON SUI NETWORK", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiccdo4jhywidk5tqmbdk4uqx5x57vjqkg76dbik3qkf4by7zux2ce")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COZCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<COZCAT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

