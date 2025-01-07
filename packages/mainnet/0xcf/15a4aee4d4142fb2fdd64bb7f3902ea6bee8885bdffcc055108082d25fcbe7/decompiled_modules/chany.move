module 0xcf15a4aee4d4142fb2fdd64bb7f3902ea6bee8885bdffcc055108082d25fcbe7::chany {
    struct CHANY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHANY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHANY>(arg0, 9, b"CHANY", b"Chained Sui", b"Chained Sui is a decentralized token on the SUI blockchain, designed for fast, secure, and scalable transactions. It connects users and platforms across the decentralized web, enabling efficient and reliable digital ecosystems. Ideal for powering DeFi and next-gen applications.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1496017876163215360/A2pOvN22.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CHANY>(&mut v2, 500000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHANY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHANY>>(v1);
    }

    // decompiled from Move bytecode v6
}

