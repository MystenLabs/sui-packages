module 0xcb31bd5e25b04cc2953b988d5497cafc38b10bcebe56b4215722d68300e018ad::babyloopy {
    struct BABYLOOPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYLOOPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYLOOPY>(arg0, 9, b"BABYLOOPY", b"BABY LOOPY", x"ed95a020ec889820ec9e88ec96b42c20eb829c20eab780ec97acec9ab0eb8b88eab98c2120f09fa4ad2057652063616e20646f20697420626563617573652077652061726520637574652120f09f8e80", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1768229968956588032/BmFmOvo5_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BABYLOOPY>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYLOOPY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BABYLOOPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

