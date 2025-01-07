module 0x864548480f3ba7b4c69efe485f17e17b450cc6e3d65afe51c6dde0f3ad28f618::rakki {
    struct RAKKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: RAKKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RAKKI>(arg0, 6, b"Rakki", b"RaKkI CaT", b"Introducing $Rakki Cat: a meme coin inspired by Japan's \"maneki-neko,\" symbolizing luck and prosperity. Built on the Sui Network, $Rakki Cat blends playful charm with real community-driven potential. Whether you're a crypto veteran or newcomer, join the growing $Rakki Cat community and unlock the opportunity for financial growth. Embrace the lucklet $Rakki Cat lead you to success.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/rr_3cfde6438d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RAKKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RAKKI>>(v1);
    }

    // decompiled from Move bytecode v6
}

