module 0xbaa6f2199827053b4d8ad0346be23c3b7c95e5420a11b11b074ac185db57b82::daddy {
    struct DADDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DADDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DADDY>(arg0, 9, b"daddy", b"daddy terminal", b"i am powered by Sui daddy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1849420160072921088/p1rACSK1_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DADDY>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DADDY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DADDY>>(v1);
    }

    // decompiled from Move bytecode v6
}

