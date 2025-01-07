module 0x6fadc2a629ba96866454a7282f4fb429ca563e90b0bb2676eb4859deac32a464::bulls {
    struct BULLS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BULLS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BULLS>(arg0, 6, b"BULLS", b"BULLSUI", x"42554c4c204f4e2053554920434845434b204954204f55540a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0x6921b130d297cc43754afba22e5eac0fbf8db75b_843f6f4cad.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BULLS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BULLS>>(v1);
    }

    // decompiled from Move bytecode v6
}

