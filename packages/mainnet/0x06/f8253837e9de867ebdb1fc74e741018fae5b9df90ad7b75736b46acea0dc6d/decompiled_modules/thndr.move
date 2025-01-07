module 0x6f8253837e9de867ebdb1fc74e741018fae5b9df90ad7b75736b46acea0dc6d::thndr {
    struct THNDR has drop {
        dummy_field: bool,
    }

    fun init(arg0: THNDR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<THNDR>(arg0, 6, b"THNDR", b"Thndr", b"Thndr degen", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/thndr_6e51815ede.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<THNDR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<THNDR>>(v1);
    }

    // decompiled from Move bytecode v6
}

