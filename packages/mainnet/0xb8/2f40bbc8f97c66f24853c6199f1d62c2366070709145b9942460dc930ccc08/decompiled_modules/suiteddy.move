module 0xb82f40bbc8f97c66f24853c6199f1d62c2366070709145b9942460dc930ccc08::suiteddy {
    struct SUITEDDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITEDDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITEDDY>(arg0, 9, b"SUITEDDY", b"Sui Teddy", b"Official token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.tbstat.com/wp/uploads/2023/10/sui_asset.jpeg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUITEDDY>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITEDDY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITEDDY>>(v1);
    }

    // decompiled from Move bytecode v6
}

