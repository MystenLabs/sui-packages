module 0xdbf26d1bbb25dce655483fafbb9c220404a943c47253e2e137c56acb72e2e322::booboo {
    struct BOOBOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOOBOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOOBOO>(arg0, 6, b"BOOBOO", b"BOO", b"boo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/random_693e6ea8de.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOOBOO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOOBOO>>(v1);
    }

    // decompiled from Move bytecode v6
}

