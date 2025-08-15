module 0x7aa0299eee3ee6e2538a6147e59f0fba47e4627cbc10d50de04c98428e1c6dac::NEWT {
    struct NEWT has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEWT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEWT>(arg0, 6, b"NEWT", b"TightToken", b"TightToken for learn", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ih1.redbubble.net/image.5148959844.2540/st,small,507x507-pad,600x600,f8f8f8.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<NEWT>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEWT>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<NEWT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

