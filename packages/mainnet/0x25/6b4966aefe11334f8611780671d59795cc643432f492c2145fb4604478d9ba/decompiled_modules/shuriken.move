module 0x256b4966aefe11334f8611780671d59795cc643432f492c2145fb4604478d9ba::shuriken {
    struct SHURIKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHURIKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHURIKEN>(arg0, 9, b"SHURIKEN", b"SHURIKEN", b"Shuriken will fly within the SUI network like stellar lightning  | https://x.com/shurikencoin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1789943635972440064/h8QiJ5ME_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SHURIKEN>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHURIKEN>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHURIKEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

