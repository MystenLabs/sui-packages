module 0x857adffeaf5b9a2e7dd2ab8cd25cdce08eecb3526b3ab10a2ede06e3bc78319a::suicide {
    struct SUICIDE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICIDE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICIDE>(arg0, 6, b"SUIcide", b"SUIcide Squad", b"SUIcide Squad represents every degen in SUI that only aims to change their lives for the better and achieve financial freedom.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SUICIDE_SQUAD_597b9660d7.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICIDE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICIDE>>(v1);
    }

    // decompiled from Move bytecode v6
}

