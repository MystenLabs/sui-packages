module 0x82634f3902e5e985f00bf8a5a685b729d95c4c8ffd34166faa7cd65fa77c91ba::sexai {
    struct SEXAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEXAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEXAI>(arg0, 9, b"SEXAI", b"DEEPSEX", b"deepseek, but DEEPER", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://media.discordapp.net/attachments/1333591553133772822/1333988443734413444/x.png?ex=679ae50d&is=6799938d&hm=f6a24dccd845850bb6b607a865aa3c4fa37ed78a98d4fc1564da7b6fc4b26ed0&=&format=webp&quality=lossless&width=437&height=411")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SEXAI>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEXAI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SEXAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

