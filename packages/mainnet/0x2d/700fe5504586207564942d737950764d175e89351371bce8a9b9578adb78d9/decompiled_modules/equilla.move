module 0x2d700fe5504586207564942d737950764d175e89351371bce8a9b9578adb78d9::equilla {
    struct EQUILLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: EQUILLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EQUILLA>(arg0, 6, b"EQUILLA", b"Equilla", b"Discover truths. Solve equations.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/453w_d36cc14c22.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EQUILLA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EQUILLA>>(v1);
    }

    // decompiled from Move bytecode v6
}

