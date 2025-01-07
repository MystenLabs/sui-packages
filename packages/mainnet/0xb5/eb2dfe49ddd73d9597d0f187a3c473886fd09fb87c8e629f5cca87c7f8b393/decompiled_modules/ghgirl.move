module 0xb5eb2dfe49ddd73d9597d0f187a3c473886fd09fb87c8e629f5cca87c7f8b393::ghgirl {
    struct GHGIRL has drop {
        dummy_field: bool,
    }

    fun init(arg0: GHGIRL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GHGIRL>(arg0, 9, b"ghgirl", b"Ghost Hunter Girl", b"Sui Ghost Hunter Girl", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdnb.artstation.com/p/assets/images/images/080/808/851/large/oleg-pavlov-morry-001.jpg?1728566070")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GHGIRL>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GHGIRL>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GHGIRL>>(v1);
    }

    // decompiled from Move bytecode v6
}

