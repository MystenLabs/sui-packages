module 0x948461654e9c230dc7421341e412e5db677e6c5da9c7044323429172363d8a20::jetfun {
    struct JETFUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: JETFUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JETFUN>(arg0, 9, b"JETFUN", b"JETT", b"https://x.com/fun_tokens", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1835435993882566656/XINpvku-_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<JETFUN>(&mut v2, 7500000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JETFUN>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JETFUN>>(v1);
    }

    // decompiled from Move bytecode v6
}

