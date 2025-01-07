module 0x52a3b553a8e1c64d23ba890c0053a31e3ffab7bb29f0f11aadc4894c5df10f66::cester {
    struct CESTER has drop {
        dummy_field: bool,
    }

    fun init(arg0: CESTER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CESTER>(arg0, 6, b"CESTER", b"Cester the Lobster on SUI", b"$CESTER is the one and only blue lobster with muscular claws on SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_5dc3f73bbf.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CESTER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CESTER>>(v1);
    }

    // decompiled from Move bytecode v6
}

