module 0xceff83c642b35c7ade0123f606828580dbbadf949e5a4c27f648f4d1462134d9::alos {
    struct ALOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ALOS>(arg0, 6, b"ALOS", b"ALOSUI", b"Hello to all of you. In case you thought I was a duck, I'm ALOS, the Long Legged Cookie, and I won't quack at you.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Lu6_Vk_YN_4_400x400_560dafc1ae.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALOS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ALOS>>(v1);
    }

    // decompiled from Move bytecode v6
}

