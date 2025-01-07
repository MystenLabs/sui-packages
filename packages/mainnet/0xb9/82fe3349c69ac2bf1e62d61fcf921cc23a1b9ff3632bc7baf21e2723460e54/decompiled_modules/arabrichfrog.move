module 0xb982fe3349c69ac2bf1e62d61fcf921cc23a1b9ff3632bc7baf21e2723460e54::arabrichfrog {
    struct ARABRICHFROG has drop {
        dummy_field: bool,
    }

    fun init(arg0: ARABRICHFROG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ARABRICHFROG>(arg0, 6, b"Arabrichfrog", b"Arab rich frog", b"Arab rich frog will list exchange! Now developing my whale friend coming!! Buy!! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Kakao_Talk_20240926_221223787_ad9c755d30.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ARABRICHFROG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ARABRICHFROG>>(v1);
    }

    // decompiled from Move bytecode v6
}

