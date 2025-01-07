module 0x4d7d78d1e2b7921d7f469e7c26b5b08be48b9a6b67ec55956474b29e68b8871a::fantoumi {
    struct FANTOUMI has drop {
        dummy_field: bool,
    }

    fun init(arg0: FANTOUMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FANTOUMI>(arg0, 6, b"Fantoumi", b"Shibu Doge Puppets", x"426f726e20746f20437265617465200a536869627520446f676520507570706574732020417574686f722020496c6c7573747261746f7220204d656d65732020414920417274200a204d61646520696e204672616e6365", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/twitter_1851575619298955471_2eba0adecf.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FANTOUMI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FANTOUMI>>(v1);
    }

    // decompiled from Move bytecode v6
}

