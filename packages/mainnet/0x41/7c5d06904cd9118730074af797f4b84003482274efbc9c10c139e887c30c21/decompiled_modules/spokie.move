module 0x417c5d06904cd9118730074af797f4b84003482274efbc9c10c139e887c30c21::spokie {
    struct SPOKIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPOKIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPOKIE>(arg0, 6, b"SPOKIE", b"Sui Pokie", b"Hi! I'm Sui Pokie $SPOKIE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000023969_6ffe031cbe.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPOKIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPOKIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

