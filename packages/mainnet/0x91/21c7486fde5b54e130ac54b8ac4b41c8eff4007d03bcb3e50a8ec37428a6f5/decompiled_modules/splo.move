module 0x9121c7486fde5b54e130ac54b8ac4b41c8eff4007d03bcb3e50a8ec37428a6f5::splo {
    struct SPLO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPLO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPLO>(arg0, 9, b"SPLO", b"Splo", b"Official token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.tbstat.com/wp/uploads/2023/10/sui_asset.jpeg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SPLO>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPLO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPLO>>(v1);
    }

    // decompiled from Move bytecode v6
}

