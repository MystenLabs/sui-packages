module 0x43531fc60173dc412156ffc50e98ba6706767157c04053a1c3eec8ffb118c21f::suibull {
    struct SUIBULL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBULL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBULL>(arg0, 9, b"SUIBULL", x"f09f908253554942554c4c", b"Official token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.tbstat.com/wp/uploads/2023/10/sui_asset.jpeg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIBULL>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBULL>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIBULL>>(v1);
    }

    // decompiled from Move bytecode v6
}

