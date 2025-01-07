module 0x9750a5e84e992c2510b41b344e0579fd7d57155a83103603a408d199f632be56::popito {
    struct POPITO has drop {
        dummy_field: bool,
    }

    fun init(arg0: POPITO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POPITO>(arg0, 6, b"POPITO", b"Popito Sui", b"POPITI is coming, a memecoin culture full of goodness", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000001206_9161a5b8d9.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POPITO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POPITO>>(v1);
    }

    // decompiled from Move bytecode v6
}

