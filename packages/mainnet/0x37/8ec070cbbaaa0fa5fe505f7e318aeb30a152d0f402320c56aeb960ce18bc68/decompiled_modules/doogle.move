module 0x378ec070cbbaaa0fa5fe505f7e318aeb30a152d0f402320c56aeb960ce18bc68::doogle {
    struct DOOGLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOOGLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOOGLE>(arg0, 6, b"DOOGLE", b"Doogle", b"Doogle, the quirky and iconic character from Matt Furies universe, has made his way to the Sui blockchain!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000039040_59f65da6a3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOOGLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOOGLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

