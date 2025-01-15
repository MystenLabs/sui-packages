module 0xbee6cf44585f248a7c0b4530510f4b181a7a1a4eb7830ff9daee4a3cd089572d::gusd {
    struct GUSD has drop {
        dummy_field: bool,
    }

    fun init(arg0: GUSD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GUSD>(arg0, 9, b"GUSD", b"GUSD", b"GUSD you have an extra special to your", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://arweave.net/zz-JUH-ODw95CAMIKfECUccPY06ERHyrxBENpFd3VW8")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GUSD>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GUSD>>(v2, @0x19cb8a3e2d0bdb221d6b0402f5d1c7bedf43efce72229aafd2379e479a8d3f59);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GUSD>>(v1);
    }

    // decompiled from Move bytecode v6
}

