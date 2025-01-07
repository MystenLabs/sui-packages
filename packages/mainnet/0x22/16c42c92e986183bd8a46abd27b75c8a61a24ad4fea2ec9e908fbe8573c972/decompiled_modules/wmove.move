module 0x2216c42c92e986183bd8a46abd27b75c8a61a24ad4fea2ec9e908fbe8573c972::wmove {
    struct WMOVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WMOVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WMOVE>(arg0, 6, b"wMOVE", b"Wrapped MOVE", b"Introducing a coin that you can trade instantly with just one click on the Sui network, all for a tiny fee! Wrapped MOVE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/4444_66659b504e_71043c5f25.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WMOVE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WMOVE>>(v1);
    }

    // decompiled from Move bytecode v6
}

