module 0x1fbf99d4a507d40f64a4a37c26919a68e5988a76c579b30b20ce62ac1c62470::godzie {
    struct GODZIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: GODZIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GODZIE>(arg0, 6, b"GODZIE", b"Godzie", b"Born from a legendary creature", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730953768257.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GODZIE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GODZIE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

