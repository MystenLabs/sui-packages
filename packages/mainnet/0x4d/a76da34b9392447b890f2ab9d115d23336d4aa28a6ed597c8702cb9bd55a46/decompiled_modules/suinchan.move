module 0x4da76da34b9392447b890f2ab9d115d23336d4aa28a6ed597c8702cb9bd55a46::suinchan {
    struct SUINCHAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINCHAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINCHAN>(arg0, 6, b"SUINCHAN", b"SUINCHAN COIN", b"SHINCHAN ON SUI $SUINCHAN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3646_93a2aef746.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINCHAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUINCHAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

