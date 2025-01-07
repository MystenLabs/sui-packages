module 0x6b63c20f5edbea71d903a5957b52df35762f8621d867ffb123b445223747f884::toshi {
    struct TOSHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOSHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOSHI>(arg0, 6, b"TOSHI", b"TOSHI ON SUI", b"$TOSHI is the 1st multi utility + meme project , join the community and lets make the new history in #SUI chain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_14_02_59_47_bb4ad20074.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOSHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TOSHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

