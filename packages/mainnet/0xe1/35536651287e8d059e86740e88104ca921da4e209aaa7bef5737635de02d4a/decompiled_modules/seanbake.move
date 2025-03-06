module 0xe135536651287e8d059e86740e88104ca921da4e209aaa7bef5737635de02d4a::seanbake {
    struct SEANBAKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEANBAKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEANBAKE>(arg0, 9, b"SEANBAKE", b"Sean Baker", b"Born: February 26, 1971, New York, New York", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://a1.moviepassblack.com/w3/assets/SEANBAKE.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SEANBAKE>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEANBAKE>>(v2, @0xebc707141970574ece90991112fe9a682d03b1596db6ca8981a29f385cbf76d6);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SEANBAKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

