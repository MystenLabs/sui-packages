module 0x14cf1f28a02333cdea7ab056458dc847cbb086822adcb8b3a3f944e7c2faa800::bink {
    struct BINK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BINK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BINK>(arg0, 6, b"BINK", b"Bonk's Sister", b"Only Sister of our Bonk!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PX_40zm_AD_400x400_5144b5ddea.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BINK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BINK>>(v1);
    }

    // decompiled from Move bytecode v6
}

