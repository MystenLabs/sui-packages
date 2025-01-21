module 0x2d53ca2692e1bb7810100e1af2709d41533e351c47c7723f1cb576ee1d25e7ab::trp {
    struct TRP has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRP>(arg0, 6, b"TRP", b"TRAMP", b"TRAMP TOKEN IS FOR THE MOTHERFUCKERS WHO FOMO LAST 2 days from $TRUMP and loss a Lot! this coin is for u MOFOS!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/trakmmp_6512945d46.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRP>>(v1);
    }

    // decompiled from Move bytecode v6
}

