module 0x5cbf73dc2d4c09ceb82d64aac1315f51c5ef6d16dd229eda3d4dc9e7589a655::whaly {
    struct WHALY has drop {
        dummy_field: bool,
    }

    fun init(arg0: WHALY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WHALY>(arg0, 9, b"WHALY", b"WHALY", b"Official token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.tbstat.com/wp/uploads/2023/10/sui_asset.jpeg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<WHALY>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WHALY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WHALY>>(v1);
    }

    // decompiled from Move bytecode v6
}

