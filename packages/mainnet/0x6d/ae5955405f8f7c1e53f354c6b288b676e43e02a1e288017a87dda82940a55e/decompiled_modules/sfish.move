module 0x6dae5955405f8f7c1e53f354c6b288b676e43e02a1e288017a87dda82940a55e::sfish {
    struct SFISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SFISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SFISH>(arg0, 6, b"sFISH", b"sui fish", b"SUIFISH is on a mission to make waves in the SUI network.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image2_3_1e740fa309.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SFISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SFISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

