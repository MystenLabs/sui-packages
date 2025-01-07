module 0x2a8e951edae2606111e40ca5f14f469901f60bd56c2a940c04cc2fd6a0384211::crazy {
    struct CRAZY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRAZY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRAZY>(arg0, 6, b"CRAZY", b"CRAZY MAN", b"fuck you all", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/crazy_7e0de26617.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRAZY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CRAZY>>(v1);
    }

    // decompiled from Move bytecode v6
}

