module 0x65ef9eafe6493ebe477858db8b3e4ac73fdf473f4b955ed157f6e01a63043804::null {
    struct NULL has drop {
        dummy_field: bool,
    }

    fun init(arg0: NULL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NULL>(arg0, 6, b"Null", b"Null and Void", b"Where nothing becomes everything.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/null_313eba5b1e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NULL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NULL>>(v1);
    }

    // decompiled from Move bytecode v6
}

