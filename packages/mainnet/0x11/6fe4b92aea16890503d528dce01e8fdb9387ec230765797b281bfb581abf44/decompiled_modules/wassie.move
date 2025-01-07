module 0x116fe4b92aea16890503d528dce01e8fdb9387ec230765797b281bfb581abf44::wassie {
    struct WASSIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WASSIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WASSIE>(arg0, 6, b"WASSIE", b"Wassie Whomp", b"$WASSIE coin is not affiliated with Tukinowagamo but is a tribute to this beloved meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000039071_11e070ed72.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WASSIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WASSIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

