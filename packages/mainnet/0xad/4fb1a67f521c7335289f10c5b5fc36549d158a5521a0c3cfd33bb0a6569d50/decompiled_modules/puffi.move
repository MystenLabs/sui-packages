module 0xad4fb1a67f521c7335289f10c5b5fc36549d158a5521a0c3cfd33bb0a6569d50::puffi {
    struct PUFFI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUFFI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUFFI>(arg0, 6, b"PUFFI", b"Puffi On Sui", x"5075666669206272696e67732074686520636f6d6d756e69747920746f67657468657220776974682068756d6f722c20737072656164696e6720676f6f64207669626573207768696c6520686967686c69676874696e67205375697320737472656e67746873206c696b6520737065656420616e642073656375726974792e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241009_172418_e9f2e92d8f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUFFI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUFFI>>(v1);
    }

    // decompiled from Move bytecode v6
}

