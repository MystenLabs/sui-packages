module 0xa73412e042832d339f4d776da8db8d1a10fdacd6e6a18c380cd04dda8a9e162b::DEFAI {
    struct DEFAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEFAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEFAI>(arg0, 9, b"DEFAI", b"DEFAI", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://caposui.xyz/assets/img/nobgcapo.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DEFAI>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<DEFAI>>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<DEFAI>>(0x2::coin::mint<DEFAI>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

