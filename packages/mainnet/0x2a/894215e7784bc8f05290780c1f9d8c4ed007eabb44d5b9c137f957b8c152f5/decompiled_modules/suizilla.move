module 0x2a894215e7784bc8f05290780c1f9d8c4ed007eabb44d5b9c137f957b8c152f5::suizilla {
    struct SUIZILLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIZILLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIZILLA>(arg0, 6, b"SUIZILLA", b"Sui Zilla", b"The beast of Sui has awakened. Bigger, badder, and ready to crush anything in its path. Brace yourself Sui Zilla is here!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PP_1080_038964054b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIZILLA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIZILLA>>(v1);
    }

    // decompiled from Move bytecode v6
}

