module 0x633ea69b4965869de5ff7a8f802f6cfe5062dc2f286a530c2823d8f04e6905a7::suibull {
    struct SUIBULL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBULL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBULL>(arg0, 9, b"SUIBULL", b"Sui Bullrun", b"Official token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.tbstat.com/wp/uploads/2023/10/sui_asset.jpeg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIBULL>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBULL>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIBULL>>(v1);
    }

    // decompiled from Move bytecode v6
}

