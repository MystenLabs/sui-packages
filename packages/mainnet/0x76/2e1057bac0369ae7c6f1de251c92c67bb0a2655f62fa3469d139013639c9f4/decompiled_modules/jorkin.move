module 0x762e1057bac0369ae7c6f1de251c92c67bb0a2655f62fa3469d139013639c9f4::jorkin {
    struct JORKIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: JORKIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JORKIN>(arg0, 6, b"JORKIN", b"jorkin", b"JORKIN IT ALL DAY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000042188_7dfefc3132.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JORKIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JORKIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

