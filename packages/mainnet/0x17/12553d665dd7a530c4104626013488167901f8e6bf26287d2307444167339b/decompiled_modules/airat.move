module 0x1712553d665dd7a530c4104626013488167901f8e6bf26287d2307444167339b::airat {
    struct AIRAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIRAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AIRAT>(arg0, 9, b"AIRAT", b"Sui Rat AI", b"AIRAT is the dominant rat in Sui ecosystem", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://iili.io/JXDwgYF.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<AIRAT>(&mut v2, 4500000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIRAT>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AIRAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

