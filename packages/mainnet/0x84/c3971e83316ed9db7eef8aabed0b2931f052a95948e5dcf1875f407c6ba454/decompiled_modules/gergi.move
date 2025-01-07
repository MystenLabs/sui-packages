module 0x84c3971e83316ed9db7eef8aabed0b2931f052a95948e5dcf1875f407c6ba454::gergi {
    struct GERGI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GERGI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GERGI>(arg0, 6, b"GERGI", b"Gergi Cat", b"Kick back, vibe out, and let Chill Kat take your crypto game to the next level. No stress, just $GERGI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000009514_5ac9d46248.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GERGI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GERGI>>(v1);
    }

    // decompiled from Move bytecode v6
}

