module 0x7c17a5a942d5031dd16785ed9e22075b929674efc5e25dc3c0b397e54d52f44b::hsn {
    struct HSN has drop {
        dummy_field: bool,
    }

    fun init(arg0: HSN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HSN>(arg0, 6, b"HSN", b"Hassan nasrallah", b"Rest in peace (RIP)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5772_826b340e55.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HSN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HSN>>(v1);
    }

    // decompiled from Move bytecode v6
}

