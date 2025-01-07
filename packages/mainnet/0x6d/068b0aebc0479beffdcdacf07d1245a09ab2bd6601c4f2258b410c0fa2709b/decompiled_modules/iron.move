module 0x6d068b0aebc0479beffdcdacf07d1245a09ab2bd6601c4f2258b410c0fa2709b::iron {
    struct IRON has drop {
        dummy_field: bool,
    }

    fun init(arg0: IRON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IRON>(arg0, 6, b"IRON", b"SUIRONMAN", b"IRONMAN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Ironman_f2102f9689.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IRON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<IRON>>(v1);
    }

    // decompiled from Move bytecode v6
}

