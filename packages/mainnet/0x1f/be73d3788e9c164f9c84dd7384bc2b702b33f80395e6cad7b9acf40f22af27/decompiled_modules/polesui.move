module 0x1fbe73d3788e9c164f9c84dd7384bc2b702b33f80395e6cad7b9acf40f22af27::polesui {
    struct POLESUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: POLESUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POLESUI>(arg0, 6, b"POLESUI", b"POLE", b"Hi im $POLE - A born in the vast, frosty waters of the Sui with a humor as the pepe , Pole embodies the chill vibe of his icy home, bringing joy and laughter wherever he goes.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3549_71b0746801.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POLESUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POLESUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

