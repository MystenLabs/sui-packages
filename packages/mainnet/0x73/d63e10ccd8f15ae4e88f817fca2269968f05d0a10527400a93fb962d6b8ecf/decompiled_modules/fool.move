module 0x73d63e10ccd8f15ae4e88f817fca2269968f05d0a10527400a93fb962d6b8ecf::fool {
    struct FOOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: FOOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FOOL>(arg0, 6, b"FOOL", b"The Fool", b"LOTM", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://storage.slaunch.xyz/staging/tokens/203384db-22b6-4bd0-9885-887045e036aa.webp")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FOOL>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FOOL>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FOOL>>(v1);
    }

    // decompiled from Move bytecode v6
}

