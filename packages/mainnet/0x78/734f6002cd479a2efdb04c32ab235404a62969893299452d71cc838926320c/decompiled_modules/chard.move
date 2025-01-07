module 0x78734f6002cd479a2efdb04c32ab235404a62969893299452d71cc838926320c::chard {
    struct CHARD has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHARD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHARD>(arg0, 6, b"CHARD", b"JUST CHARD", b"the dog with a heart", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2_b6d1c7a440.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHARD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHARD>>(v1);
    }

    // decompiled from Move bytecode v6
}

