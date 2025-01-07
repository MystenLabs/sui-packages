module 0x162bc00af09a1e023d7908b859acdf7bd83c9f1c5a03a02ab9584030bd6f6da1::socks {
    struct SOCKS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOCKS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOCKS>(arg0, 6, b"SOCKS", b"socks", b"Socks, the White House cat during the Clinton administration who waged war on Buddy the pup, has died. He was around 18.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0013729e42d20b0c864b23_b2fa9f62c2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOCKS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOCKS>>(v1);
    }

    // decompiled from Move bytecode v6
}

