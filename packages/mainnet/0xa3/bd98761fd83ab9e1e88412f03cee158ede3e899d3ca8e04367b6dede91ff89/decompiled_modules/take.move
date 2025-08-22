module 0xa3bd98761fd83ab9e1e88412f03cee158ede3e899d3ca8e04367b6dede91ff89::take {
    struct TAKE has drop {
        dummy_field: bool,
    }

    fun create_coin(arg0: TAKE, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<TAKE> {
        let (v0, v1) = 0x2::coin::create_currency<TAKE>(arg0, 9, b"TT", b"TestToken!", b"sss", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.gstatic.com/kpui/social/fb_32x32.png")), arg2);
        let v2 = v0;
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TAKE>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<TAKE>>(v2);
        0x2::coin::mint<TAKE>(&mut v2, arg1, arg2)
    }

    fun init(arg0: TAKE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = create_coin(arg0, 1000000000000000000, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<TAKE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

