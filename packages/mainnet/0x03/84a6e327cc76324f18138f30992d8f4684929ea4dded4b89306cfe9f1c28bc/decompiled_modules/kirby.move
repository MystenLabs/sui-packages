module 0x384a6e327cc76324f18138f30992d8f4684929ea4dded4b89306cfe9f1c28bc::kirby {
    struct KIRBY has drop {
        dummy_field: bool,
    }

    fun init(arg0: KIRBY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KIRBY>(arg0, 6, b"KIRBY", b"Kirby", b"https://en.m.wikipedia.org/wiki/Kirby_(character)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000029118_75e9ae96f2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KIRBY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KIRBY>>(v1);
    }

    // decompiled from Move bytecode v6
}

