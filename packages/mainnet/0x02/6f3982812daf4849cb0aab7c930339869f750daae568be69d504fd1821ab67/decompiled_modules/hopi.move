module 0x26f3982812daf4849cb0aab7c930339869f750daae568be69d504fd1821ab67::hopi {
    struct HOPI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOPI>(arg0, 6, b"HOPI", b"HOPIONSUI", b"The hilariously clueless hippo who always gets into ridiculous jungle mishaps! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241004_183446_3d049e02ef.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOPI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOPI>>(v1);
    }

    // decompiled from Move bytecode v6
}

