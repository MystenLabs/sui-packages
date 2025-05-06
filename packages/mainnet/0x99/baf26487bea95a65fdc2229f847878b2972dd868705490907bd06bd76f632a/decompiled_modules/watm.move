module 0x99baf26487bea95a65fdc2229f847878b2972dd868705490907bd06bd76f632a::watm {
    struct WATM has drop {
        dummy_field: bool,
    }

    fun init(arg0: WATM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WATM>(arg0, 6, b"WATM", b"We are the media", b" $WATM: Your local owl disrupting media by doing absolutely nothing except turning everyone into journalists. No rules, just vibes and memes mandatory.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000088478_01dfb90c18.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WATM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WATM>>(v1);
    }

    // decompiled from Move bytecode v6
}

