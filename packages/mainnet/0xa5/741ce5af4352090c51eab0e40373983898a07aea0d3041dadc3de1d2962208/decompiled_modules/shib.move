module 0xa5741ce5af4352090c51eab0e40373983898a07aea0d3041dadc3de1d2962208::shib {
    struct SHIB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHIB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHIB>(arg0, 9, b"SHIB", b"Shib sInu", b"Shiba Inu (SHIB) is a decentralized meme token that has gained massive popularity in the crypto world. Known as the \"Dogecoin killer,\" SHIB started as a playful, community-driven project and has since evolved into a larger ecosystem. Its lighthearted branding and active community have made it a prominent player in the meme coin space.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1675593177875488768/zntg1iI4.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SHIB>(&mut v2, 1500000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHIB>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHIB>>(v1);
    }

    // decompiled from Move bytecode v6
}

