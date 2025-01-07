module 0x473544a1169d1f6dcfe77727d969cfe975d8ba37c313e5bc492a28f3d32dc8cf::null {
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

