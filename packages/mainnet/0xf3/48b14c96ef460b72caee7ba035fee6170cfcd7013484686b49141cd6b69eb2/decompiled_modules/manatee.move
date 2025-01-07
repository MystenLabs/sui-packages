module 0xf348b14c96ef460b72caee7ba035fee6170cfcd7013484686b49141cd6b69eb2::manatee {
    struct MANATEE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MANATEE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MANATEE>(arg0, 6, b"Manatee", b"Sui Manatee", b"The Sui Manatee floats through the Sui blockchain like a peaceful giant. Its a symbol of calm strength, steady and reliable, making waves without rushing. Just like the manatee, this token takes its time, but its here to stay.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Manatee_1a63bd8010.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MANATEE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MANATEE>>(v1);
    }

    // decompiled from Move bytecode v6
}

