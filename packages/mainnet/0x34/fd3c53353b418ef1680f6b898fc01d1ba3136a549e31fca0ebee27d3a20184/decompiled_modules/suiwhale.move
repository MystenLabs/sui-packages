module 0x34fd3c53353b418ef1680f6b898fc01d1ba3136a549e31fca0ebee27d3a20184::suiwhale {
    struct SUIWHALE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIWHALE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIWHALE>(arg0, 9, b"SUIWHALE", b"Sui Whale", b"Official token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.tbstat.com/wp/uploads/2023/10/sui_asset.jpeg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIWHALE>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIWHALE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIWHALE>>(v1);
    }

    // decompiled from Move bytecode v6
}

