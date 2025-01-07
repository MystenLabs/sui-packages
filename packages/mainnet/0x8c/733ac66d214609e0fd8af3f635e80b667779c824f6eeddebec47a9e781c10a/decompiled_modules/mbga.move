module 0x8c733ac66d214609e0fd8af3f635e80b667779c824f6eeddebec47a9e781c10a::mbga {
    struct MBGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MBGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MBGA>(arg0, 9, b"MBGA", b"MAKE BITCOIN GREAT AGAIN", x"4368616e6e656c696e672074686520737069726974206f6620506574657220546f64642c207765e280997265206865726520746f206272696e67207468652066756e206261636b20746f2063727970746f21204c6574e280997320726964652074686973207761766520746f67657468657220616e642073686f772074686520776f726c6420776861742074686520244d42474120636f6d6d756e69747920697320616c6c2061626f75742120f09f92aa", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/uNJVggxGKywYehwEXf4u7joXucqrMYudUDphUYEpump.png?size=lg&key=e5d30e")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MBGA>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MBGA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MBGA>>(v1);
    }

    // decompiled from Move bytecode v6
}

