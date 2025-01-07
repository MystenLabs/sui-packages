module 0x79793aab27015195830af20fa48ecc146681e7cbf04e6bae5f4b13900625108::kraken {
    struct KRAKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: KRAKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KRAKEN>(arg0, 6, b"KRAKEN", b"Kraken", b"Release the Kraken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/kraken_6ef419231f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KRAKEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KRAKEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

