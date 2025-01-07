module 0xa1777463b18a3f0c0860c87203c83846928bdc8e2dc1aa9691eb6a947ce82979::sowl {
    struct SOWL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOWL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOWL>(arg0, 6, b"SOWL", b"SowlOnSui", b"$SOWL the only one OWL on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000345_ba8a49639d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOWL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOWL>>(v1);
    }

    // decompiled from Move bytecode v6
}

