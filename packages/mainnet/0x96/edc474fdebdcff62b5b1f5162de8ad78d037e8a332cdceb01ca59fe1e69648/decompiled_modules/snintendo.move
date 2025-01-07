module 0x96edc474fdebdcff62b5b1f5162de8ad78d037e8a332cdceb01ca59fe1e69648::snintendo {
    struct SNINTENDO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNINTENDO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNINTENDO>(arg0, 6, b"SNINTENDO", b"Suiper-Nintendo", x"5375697065722d4e696e74656e646f20776173206372656174656420666f7220616c6c204e696e74656e646f2066616e732121210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://movepump.xyz/uploads/1000000488_ed29ffaa62.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNINTENDO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SNINTENDO>>(v1);
    }

    // decompiled from Move bytecode v6
}

