module 0xb0698c75e954315f95b822d6638c6a80c80ddad594cf6b3931708bd41ebfbee8::shtmos {
    struct SHTMOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHTMOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHTMOS>(arg0, 6, b"SHTMOS", b"Shitmos", b"Fly on a shit", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Ch_megacephala_wiki_b57ba74128.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHTMOS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHTMOS>>(v1);
    }

    // decompiled from Move bytecode v6
}

