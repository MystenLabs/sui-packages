module 0xe4895416846d456daa2b12fe3c1724906a255a377f3c3d05441fe6ffc7394baa::lido {
    struct LIDO has drop {
        dummy_field: bool,
    }

    fun init(arg0: LIDO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LIDO>(arg0, 9, b"LIDO", b"Lido", b"A community project that provides news, updates and original content related to Lido Ecosystem.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1869062399132844036/YiKINOYh_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<LIDO>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LIDO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LIDO>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

