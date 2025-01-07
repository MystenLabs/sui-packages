module 0x60670a19815458c1d77a2375b3868cfef0764917408e6e3fb5b2da0955945062::fonk {
    struct FONK has drop {
        dummy_field: bool,
    }

    fun init(arg0: FONK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FONK>(arg0, 6, b"FONK", b"Fonk Inu", b"$Fonk The best friend of Bonk in Pepe village. This time, let Fonk take reign.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/5454_b2afcb8d0e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FONK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FONK>>(v1);
    }

    // decompiled from Move bytecode v6
}

