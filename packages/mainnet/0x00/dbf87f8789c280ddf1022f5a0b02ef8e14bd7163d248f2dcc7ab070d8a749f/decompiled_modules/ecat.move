module 0xdbf87f8789c280ddf1022f5a0b02ef8e14bd7163d248f2dcc7ab070d8a749f::ecat {
    struct ECAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: ECAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ECAT>(arg0, 6, b"ECAT", b"ELON CAT FINANCE", b"A USEFUL WEB3 ECOSYSTEM: STAKING | DEX EXCHANGE | NFT MARKET | MULTIPLE CHAIN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/9d_Kp9fp8_400x400_98c79ec243.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ECAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ECAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

