module 0x6043b062b7e5da6032d091507f9e89cf168348a806d5f29d2db2a105a7b2ca6::degens {
    struct DEGENS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEGENS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEGENS>(arg0, 6, b"DEGENS", b"DEGEN SUI", x"446567656e206f6e207375690a4c46474747212121", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000322267_6b36f6b664.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEGENS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DEGENS>>(v1);
    }

    // decompiled from Move bytecode v6
}

