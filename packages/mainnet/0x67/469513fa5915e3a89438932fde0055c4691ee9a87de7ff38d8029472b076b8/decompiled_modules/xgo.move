module 0x67469513fa5915e3a89438932fde0055c4691ee9a87de7ff38d8029472b076b8::xgo {
    struct XGO has drop {
        dummy_field: bool,
    }

    fun init(arg0: XGO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XGO>(arg0, 6, b"XGO", b"Xtreme Gains Only", b"Xtreme Gains Only!  A meme token with humor and a serious goal to maximize profits for its holders", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/479427417_1346020053501428_5380279979545282621_n_76268cd45b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XGO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<XGO>>(v1);
    }

    // decompiled from Move bytecode v6
}

