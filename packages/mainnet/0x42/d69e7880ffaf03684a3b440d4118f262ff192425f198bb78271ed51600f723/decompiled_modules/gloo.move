module 0x42d69e7880ffaf03684a3b440d4118f262ff192425f198bb78271ed51600f723::gloo {
    struct GLOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: GLOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GLOO>(arg0, 6, b"GLOO", b"gloosui.xyz", b"Be Gloo, be Bloo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1736020462566_ec20703ecf.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GLOO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GLOO>>(v1);
    }

    // decompiled from Move bytecode v6
}

