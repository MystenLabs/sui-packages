module 0xce51d0ed4a1593fc0bd6aa19e93badf39d360722f92c70ac5d2b3a22f9d5c630::ftr {
    struct FTR has drop {
        dummy_field: bool,
    }

    fun init(arg0: FTR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FTR>(arg0, 6, b"FTR", b"Frosty The Rizzman", b"He's too cold for these hoes. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241129_103726_779_e4dac90f5e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FTR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FTR>>(v1);
    }

    // decompiled from Move bytecode v6
}

