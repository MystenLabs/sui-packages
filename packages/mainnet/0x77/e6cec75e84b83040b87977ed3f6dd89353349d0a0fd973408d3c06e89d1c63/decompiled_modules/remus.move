module 0x77e6cec75e84b83040b87977ed3f6dd89353349d0a0fd973408d3c06e89d1c63::remus {
    struct REMUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: REMUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REMUS>(arg0, 6, b"REMUS", b"Ancient DNA Cloned Wolf", x"7c546865204469726520576f6c66204973204261636b7c0a0a436f6c6f7373616c2c20612067656e657469637320737461727475702c2068617320626972746865642074687265652070757073207468617420636f6e7461696e20616e6369656e7420444e41207265747269657665642066726f6d207468652072656d61696e73206f662074686520616e696d616c7320657874696e637420616e636573746f72732e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/remus_e5a37728d8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REMUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<REMUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

