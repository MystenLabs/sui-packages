module 0x714710daf7bcd145e9aae44d94ebc3473c49fadc0c4c36169ff64d234f1c4196::sml {
    struct SML has drop {
        dummy_field: bool,
    }

    fun init(arg0: SML, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SML>(arg0, 6, b"SML", b"S AI AGENT", b"S AI AGENT ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/singed_astronaut_762x_663f7e5e0f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SML>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SML>>(v1);
    }

    // decompiled from Move bytecode v6
}

