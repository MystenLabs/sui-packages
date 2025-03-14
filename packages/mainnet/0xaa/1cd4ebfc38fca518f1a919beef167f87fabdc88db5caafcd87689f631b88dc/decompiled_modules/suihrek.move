module 0xaa1cd4ebfc38fca518f1a919beef167f87fabdc88db5caafcd87689f631b88dc::suihrek {
    struct SUIHREK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIHREK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIHREK>(arg0, 6, b"SUIHREK", b"SHREK on SUI Ocean", b"Suihrek has become a cultural icon, often featured in fan art, memes, and even creative projects.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SUIHREK_9845247caf.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIHREK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIHREK>>(v1);
    }

    // decompiled from Move bytecode v6
}

