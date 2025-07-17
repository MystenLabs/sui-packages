module 0xdc77f607cbe9b27a94c2bf20dcecab073f9b7b78bac17273146d40d25a3ea89a::chillhouse {
    struct CHILLHOUSE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHILLHOUSE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHILLHOUSE>(arg0, 6, b"CHILLHOUSE", b"Chill House (CHILLHOUSE)", b"just a chill house", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidjx63ihbw2vey7i5b4hk37jxypah6hayfxidir4hsh5bkcuvtre4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHILLHOUSE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CHILLHOUSE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

