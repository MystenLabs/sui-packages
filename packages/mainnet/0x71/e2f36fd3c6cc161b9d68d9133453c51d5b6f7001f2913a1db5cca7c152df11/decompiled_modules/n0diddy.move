module 0x71e2f36fd3c6cc161b9d68d9133453c51d5b6f7001f2913a1db5cca7c152df11::n0diddy {
    struct N0DIDDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: N0DIDDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<N0DIDDY>(arg0, 6, b"N0DIDDY", b"No Diddy", b"Come join the No Diddy Community as we go throughout his whole Rico Case. We will reach numbers like no others as community grows. REMEMBER THERES NO PARTY LIKE A DIDDY PARTY. NO DIDDY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_6241_dbef5e529e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<N0DIDDY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<N0DIDDY>>(v1);
    }

    // decompiled from Move bytecode v6
}

