module 0x1ad49ce9c7b62e2b826ffca69b1f5eca9ab85163c515089999d84d4db9143c44::psuiduck {
    struct PSUIDUCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: PSUIDUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PSUIDUCK>(arg0, 6, b"PSUIDUCK", b"PSUIduck", x"68747470733a2f2f707375696475636b2e676974626f6f6b2e696f2f707375696475636b2d776869746570617065720a0a50737569447575757575636b", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000028538_b7fc3cebc6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PSUIDUCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PSUIDUCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

