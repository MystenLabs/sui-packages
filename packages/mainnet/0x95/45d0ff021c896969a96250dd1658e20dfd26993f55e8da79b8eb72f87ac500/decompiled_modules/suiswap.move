module 0x9545d0ff021c896969a96250dd1658e20dfd26993f55e8da79b8eb72f87ac500::suiswap {
    struct SUISWAP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISWAP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISWAP>(arg0, 9, b"SUISWAP", b"SUISWAP", b"Official token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.tbstat.com/wp/uploads/2023/10/sui_asset.jpeg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUISWAP>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISWAP>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISWAP>>(v1);
    }

    // decompiled from Move bytecode v6
}

