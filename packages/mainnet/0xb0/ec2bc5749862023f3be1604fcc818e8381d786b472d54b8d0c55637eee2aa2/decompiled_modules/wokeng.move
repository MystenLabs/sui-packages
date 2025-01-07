module 0xb0ec2bc5749862023f3be1604fcc818e8381d786b472d54b8d0c55637eee2aa2::wokeng {
    struct WOKENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOKENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOKENG>(arg0, 9, b"WOKENG", b"Sui Wokeng", b"wokeng da keng of da flewor end freit mewntain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pump.mypinata.cloud/ipfs/QmNikZ6VSn47SN3R19oR5sJ1WPSS3qsjVMAr6y8HKLCL2n?img-width=256&img-dpr=2&img-onerror=redirect")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<WOKENG>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOKENG>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WOKENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

