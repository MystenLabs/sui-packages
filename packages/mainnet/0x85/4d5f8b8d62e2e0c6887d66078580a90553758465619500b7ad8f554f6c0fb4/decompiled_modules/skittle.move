module 0x854d5f8b8d62e2e0c6887d66078580a90553758465619500b7ad8f554f6c0fb4::skittle {
    struct SKITTLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKITTLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKITTLE>(arg0, 6, b"SKITTLE", b"SKITTLES", b"Hey every one! My name is Skittles! Yes, I am real! I am coming to SUI Network! 1st stop, MOVEPUMP.   I have lots of pictures and selfies to share!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/6894486575403610509_1_821beefe26.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKITTLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SKITTLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

