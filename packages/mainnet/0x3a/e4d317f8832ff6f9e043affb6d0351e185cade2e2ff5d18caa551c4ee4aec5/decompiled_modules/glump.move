module 0x3ae4d317f8832ff6f9e043affb6d0351e185cade2e2ff5d18caa551c4ee4aec5::glump {
    struct GLUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: GLUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GLUMP>(arg0, 6, b"GLUMP", b"SUI GLUMP", b"A little weird and sometimes silly, glump is something special, nobody really knows what he is.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/glump_2b34ea1169.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GLUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GLUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

