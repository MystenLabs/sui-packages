module 0x8c3c63faf9351772f34c19c6b914b20c641088f45f55d5c192de9b9aea6e4b0::suibob {
    struct SUIBOB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBOB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBOB>(arg0, 6, b"Suibob", b"Bob on SUI", b"suibob is a meme   coin    on  suinetwork.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/123_78da66167c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBOB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIBOB>>(v1);
    }

    // decompiled from Move bytecode v6
}

