module 0x5a45b59934e481fe3fbc7a67ec1aea041a5a9b8cb5b9401c37e3cdbed3b5bac0::sotter {
    struct SOTTER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOTTER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOTTER>(arg0, 6, b"SOTTER", b"SUI OTTER", b"The mascot of Sui chain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sotterlogo_dd28ba2cb8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOTTER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOTTER>>(v1);
    }

    // decompiled from Move bytecode v6
}

