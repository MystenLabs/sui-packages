module 0xe85b30ac9f24994b310d4af8c15fc1e60f5519b0837584ec100554e6374b5806::spdr {
    struct SPDR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPDR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPDR>(arg0, 6, b"SPDR", b"SUIPIDERMAN", b"Friendly neighborhood SUIPIDERMAN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/spooder_a4fb0cb6d9.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPDR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPDR>>(v1);
    }

    // decompiled from Move bytecode v6
}

