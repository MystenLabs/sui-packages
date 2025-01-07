module 0x94d64fa57c343a527f10d91395880ba4f259554e648f687e2455a4864ce6482a::cans {
    struct CANS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CANS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CANS>(arg0, 6, b"CANS", b"All the Beers I drunk", b"All the beers  drunk..", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5823_77d76696d1.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CANS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CANS>>(v1);
    }

    // decompiled from Move bytecode v6
}

