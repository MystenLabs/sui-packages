module 0x9e9063bf268ce2e941a6f8c6d8bfe2ce75bfe55a16b74edbfd478233ee0b916b::suigld {
    struct SUIGLD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIGLD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIGLD>(arg0, 6, b"SUIGLD", b"SUI GOLD", b"Sui Gold on the SUI network! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GOLDSUILOGO_388ecdc8dd.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIGLD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIGLD>>(v1);
    }

    // decompiled from Move bytecode v6
}

