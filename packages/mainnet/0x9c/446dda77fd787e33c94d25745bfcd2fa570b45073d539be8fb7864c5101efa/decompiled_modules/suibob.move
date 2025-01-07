module 0x9c446dda77fd787e33c94d25745bfcd2fa570b45073d539be8fb7864c5101efa::suibob {
    struct SUIBOB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBOB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBOB>(arg0, 6, b"SUIBOB", b"SUI BOB", b"100M On the way!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_2345_d23f54175c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBOB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIBOB>>(v1);
    }

    // decompiled from Move bytecode v6
}

