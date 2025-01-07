module 0x1c0b80deaa42b36173ecd6040f57c2a8ddbadf0e0c9b4f63102ac80dc9219f6d::retard {
    struct RETARD has drop {
        dummy_field: bool,
    }

    fun init(arg0: RETARD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RETARD>(arg0, 6, b"RETARD", b"retard", b"still swimmenng sui in my huead", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pp_504x498_pad_600x600_f8f8f8_daa428ace2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RETARD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RETARD>>(v1);
    }

    // decompiled from Move bytecode v6
}

