module 0x737d1973ff4cbcf02be212b17af942079724cfdc60f7ca0a4e596c792c0c6fd8::suimove {
    struct SUIMOVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMOVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMOVE>(arg0, 9, b"SUIMOVE", b"Suimove", b"Official token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.tbstat.com/wp/uploads/2023/10/sui_asset.jpeg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIMOVE>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMOVE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMOVE>>(v1);
    }

    // decompiled from Move bytecode v6
}

