module 0xca370cddf5069c73e8dd663c24f6027c2b99ee82d00d7aa77dc518743972644f::greenbro {
    struct GREENBRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: GREENBRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GREENBRO>(arg0, 6, b"GREENBRO", b"GreenBro", b"Green, bro.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000053375_d2358770f7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GREENBRO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GREENBRO>>(v1);
    }

    // decompiled from Move bytecode v6
}

