module 0x84d8f3d1d88f8974980793c354f1e25cd46d401d0081a917be2eb7af57d7ad79::bullrun {
    struct BULLRUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BULLRUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BULLRUN>(arg0, 9, b"BULLRUN", b"BULLRUN", b"Official token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.tbstat.com/wp/uploads/2023/10/sui_asset.jpeg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BULLRUN>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BULLRUN>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BULLRUN>>(v1);
    }

    // decompiled from Move bytecode v6
}

