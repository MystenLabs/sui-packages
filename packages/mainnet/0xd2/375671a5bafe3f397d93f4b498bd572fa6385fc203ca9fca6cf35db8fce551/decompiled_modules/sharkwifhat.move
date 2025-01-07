module 0xd2375671a5bafe3f397d93f4b498bd572fa6385fc203ca9fca6cf35db8fce551::sharkwifhat {
    struct SHARKWIFHAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHARKWIFHAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHARKWIFHAT>(arg0, 6, b"SHARKWIFHAT", b"Shark Wif Hat", b"A shark with a hat. What more could you ask for? This suave predator is swimming through the Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PP_1_31612640c3.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHARKWIFHAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHARKWIFHAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

