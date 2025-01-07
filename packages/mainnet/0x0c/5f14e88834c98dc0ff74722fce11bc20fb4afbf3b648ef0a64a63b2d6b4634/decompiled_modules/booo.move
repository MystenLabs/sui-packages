module 0xc5f14e88834c98dc0ff74722fce11bc20fb4afbf3b648ef0a64a63b2d6b4634::booo {
    struct BOOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOOO>(arg0, 9, b"BOOO", b"BOOO", b"Official token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.tbstat.com/wp/uploads/2023/10/sui_asset.jpeg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BOOO>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOOO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOOO>>(v1);
    }

    // decompiled from Move bytecode v6
}

