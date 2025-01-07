module 0x875d61abebe0a8a9b036954bcf6306a490215368f0cde53dbee98106ebdfb851::noodles {
    struct NOODLES has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOODLES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOODLES>(arg0, 6, b"NOODLES", b"Sui Ramen", b"Sui Ramen is the treat that all crypto traders need. Get a bowl and kick back.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/7_30077aa06a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOODLES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NOODLES>>(v1);
    }

    // decompiled from Move bytecode v6
}

