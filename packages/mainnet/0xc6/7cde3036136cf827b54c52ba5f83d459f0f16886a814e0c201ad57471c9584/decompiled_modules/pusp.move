module 0xc67cde3036136cf827b54c52ba5f83d459f0f16886a814e0c201ad57471c9584::pusp {
    struct PUSP has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUSP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUSP>(arg0, 6, b"PUSP", b"PUPSUI", x"2450555053206973207468652066697273742063756c7475726520636f696e206f6e207375692e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/n_Wldt1_Qq_400x400_8ebb2ab4f1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUSP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUSP>>(v1);
    }

    // decompiled from Move bytecode v6
}

