module 0xbd8cc72a449b5c26175914aa110ad00f976cf93ccc605dfc450bd1dfcc59ba79::glump {
    struct GLUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: GLUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GLUMP>(arg0, 6, b"GLUMP", b"Glump", b"A little weird and sometimes silly, glump is something special, nobody really knows what he is.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Fighting_32_975f363710.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GLUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GLUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

