module 0x4511d961febe5ce599de2302fbac33592c18a1d0a77b09ccbdb3178796dafeb0::none {
    struct NONE has drop {
        dummy_field: bool,
    }

    fun init(arg0: NONE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NONE>(arg0, 6, b"NONE", b"Naked NonneOnSui", b"$NONE on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241009_025206_a93512dc1a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NONE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NONE>>(v1);
    }

    // decompiled from Move bytecode v6
}

