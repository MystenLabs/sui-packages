module 0xfc8f28b94bb5322aed614fa859371639d32e3ba2a0bb4be84a3a0f151b7c0f82::otto {
    struct OTTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: OTTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OTTO>(arg0, 6, b"OTTO", b"Sui Otto", b"$Otto is an angry otter tired of the jeeters", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/500x500_24_766117eb17.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OTTO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OTTO>>(v1);
    }

    // decompiled from Move bytecode v6
}

