module 0xc930a4da350a8d2d50e70c11164971c55a4541c778ebc1eaf072949f637b357c::doby {
    struct DOBY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOBY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOBY>(arg0, 6, b"DOBY", b"Sui Doby", b"$GOBY He's the ultimate icon everyone dreams of becoming and the next mascot of SUI!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/goby_daa5a16f54.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOBY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOBY>>(v1);
    }

    // decompiled from Move bytecode v6
}

