module 0xa921b968fb0bbfc9ab2cbf77b408b4a200be74d3f41f8de0e832eb7051ee1fb::white {
    struct WHITE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WHITE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WHITE>(arg0, 9, b"WHITE", x"e2ac9c5768697445", b"Official token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.tbstat.com/wp/uploads/2023/10/sui_asset.jpeg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<WHITE>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WHITE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WHITE>>(v1);
    }

    // decompiled from Move bytecode v6
}

