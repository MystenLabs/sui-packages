module 0x8de66dce2977c37c5ba064266597e75d242009133e0ab16478f19391a021ef60::cvb {
    struct CVB has drop {
        dummy_field: bool,
    }

    fun init(arg0: CVB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CVB>(arg0, 6, b"CVB", b"fvgb", b"sdfds", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihfplmxmsq6upbkjkr6jmzhmsgdfknjhzffwuogorskx34qmokr4m")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CVB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CVB>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

