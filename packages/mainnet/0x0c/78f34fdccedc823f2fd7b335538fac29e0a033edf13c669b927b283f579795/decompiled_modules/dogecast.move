module 0xc78f34fdccedc823f2fd7b335538fac29e0a033edf13c669b927b283f579795::dogecast {
    struct DOGECAST has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGECAST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGECAST>(arg0, 6, b"DOGECAST", b"FIRST DOGECAST ON SUI", b"FIRST DOGECAST ON SUI: dogecastonsui.fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logo_1_1_4_19cd5e808e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGECAST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGECAST>>(v1);
    }

    // decompiled from Move bytecode v6
}

