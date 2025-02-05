module 0x58a92e06781bfb74ad7ca48416bbe0e38333864d65d3cb982caa3a8b0425c908::antman {
    struct ANTMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANTMAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANTMAN>(arg0, 9, b"ANTMAN", b"Ant-Man", b"The heist movie that proved small heroes can make it big", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://m.media-amazon.com/images/M/MV5BMjM2NTQ5Mzc2M15BMl5BannerXkFtZTgwNTcxMDI2NTE@._V1_.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ANTMAN>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANTMAN>>(v2, @0xebc707141970574ece90991112fe9a682d03b1596db6ca8981a29f385cbf76d6);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ANTMAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

