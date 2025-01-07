module 0x6da938418f04b8612cedfd9dcd11c38399c8c24be6408512e3250b358a3044cc::slizzy {
    struct SLIZZY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLIZZY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLIZZY>(arg0, 6, b"SLIZZY", b"SLIZZY SUI", b"Slizzy Adventures", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_6687_0a7d923436.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLIZZY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SLIZZY>>(v1);
    }

    // decompiled from Move bytecode v6
}

