module 0x9c1edeb18354e92283974ee85f3a11d30c92d65d3cb5523aa0563d586d0aa0f8::stbr {
    struct STBR has drop {
        dummy_field: bool,
    }

    fun init(arg0: STBR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STBR>(arg0, 9, b"STBR", b"Sutomber", b"Sutomber (STBR) Sutomber is a versatile token on the Sui blockchain, designed for seamless transactions and scalability in the Web3 ecosystem. With its efficient, low-cost structure, Sutomber empowers developers and users alike, supporting a new wave of decentralized applications and secure digital assets.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1742847272369700864/2kVujfip.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<STBR>(&mut v2, 1330000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STBR>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STBR>>(v1);
    }

    // decompiled from Move bytecode v6
}

