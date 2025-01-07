module 0x5a555a4c494e1b9e74e809889379ab4fadb2e82fec6387c28afbf6fdefd1bbd7::suineyland {
    struct SUINEYLAND has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINEYLAND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINEYLAND>(arg0, 9, b"SUINEYLAND", b"SUINEYLAND", b"Official token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.tbstat.com/wp/uploads/2023/10/sui_asset.jpeg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUINEYLAND>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINEYLAND>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUINEYLAND>>(v1);
    }

    // decompiled from Move bytecode v6
}

