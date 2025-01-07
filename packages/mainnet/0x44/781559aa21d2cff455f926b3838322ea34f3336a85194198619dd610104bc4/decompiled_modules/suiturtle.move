module 0x44781559aa21d2cff455f926b3838322ea34f3336a85194198619dd610104bc4::suiturtle {
    struct SUITURTLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITURTLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITURTLE>(arg0, 6, b"SUITURTLE", b"Sui Turtle", x"2253756920547572746c653a20546865206d656d6520636f696e206f6620537569204e6574776f726b2120536c6f772c207374656164792c20616e642066756e20206a6f696e20746865207368656c6c20737175616420616e642072696465207468652053756920776176652e20457665727920747572746c6520686173206974732064617921220a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_07_213048_563ebe9cde.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITURTLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITURTLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

