module 0x3250980701d76e4f14a04e7b631cc141218cf4b58762e8f3a1596372af174a74::usdt {
    struct USDT has drop {
        dummy_field: bool,
    }

    fun init(arg0: USDT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USDT>(arg0, 9, b"USDT", b"Tether", b"Tether on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.pinata.cloud/ipfs/QmUyRS4FRYcF87wQZZegLxpuq1y7g482PBb6CDissDeYhj")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<USDT>(&mut v2, 100000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USDT>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<USDT>>(v1);
    }

    // decompiled from Move bytecode v6
}

