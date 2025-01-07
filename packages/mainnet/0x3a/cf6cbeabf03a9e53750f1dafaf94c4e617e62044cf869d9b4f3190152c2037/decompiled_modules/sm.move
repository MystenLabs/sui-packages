module 0x3acf6cbeabf03a9e53750f1dafaf94c4e617e62044cf869d9b4f3190152c2037::sm {
    struct SM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SM>(arg0, 6, b"SM", b"SUI Monsters", b"SUI, they are actually monsters)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PX_M_8c7eb15dd4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SM>>(v1);
    }

    // decompiled from Move bytecode v6
}

