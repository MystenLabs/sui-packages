module 0x877b553815681bc5496ffa78a50d99386f1b381f974a80a9adbd3280e45c6c6c::OJ {
    struct OJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: OJ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OJ>(arg0, 6, b"Justice but Orange", b"OJ", b"weird flex but k", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"ICoN_URL_STRING_PLACEHOLDER")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OJ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OJ>>(v1);
    }

    // decompiled from Move bytecode v6
}

