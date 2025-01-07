module 0x1202e602f8657f809a1dfe660f85ae7feb8de58ce2e75b68965804fefb1c7470::ppunk {
    struct PPUNK has drop {
        dummy_field: bool,
    }

    fun init(arg0: PPUNK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PPUNK>(arg0, 6, b"PPUNK", b"Pink Punk", b"All-in one smart trading bot", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000013794_91f75bb88f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PPUNK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PPUNK>>(v1);
    }

    // decompiled from Move bytecode v6
}

