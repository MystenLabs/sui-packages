module 0xe82e1e5b77c2c6637ee0cb52e0efff623d440618e9802db8745241999cde60b8::hopdelay {
    struct HOPDELAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPDELAY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOPDELAY>(arg0, 6, b"HOPDELAY", b"HOP DELAY", b"This meme is shit lol!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/G9_NH_V7z_400x400_712b85537f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOPDELAY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOPDELAY>>(v1);
    }

    // decompiled from Move bytecode v6
}

