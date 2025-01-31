module 0x8ab2f591ef06b3ed136e91b862a6fd0530d80235113d4e7c2688ffd9e0334b92::smia {
    struct SMIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMIA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMIA>(arg0, 6, b"SMIA", b"SUI MADE IN AMERICA", b"$smia is the symbol of a new financial erastrong, independent, and built on the American-made SUI blockchain. It embodies freedom, transparency, and innovation, removing borders and intermediaries. With the backing of U.S. crypto reserves, $smia paves the way for true financial independence.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_8f1c6d32ab.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMIA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMIA>>(v1);
    }

    // decompiled from Move bytecode v6
}

