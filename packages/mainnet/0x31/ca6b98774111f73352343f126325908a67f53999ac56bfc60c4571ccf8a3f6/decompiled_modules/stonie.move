module 0x31ca6b98774111f73352343f126325908a67f53999ac56bfc60c4571ccf8a3f6::stonie {
    struct STONIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: STONIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STONIE>(arg0, 6, b"STONIE", b"Sui Stonie", x"4d6565742053746f6e69652c207468652068696768657374206d656d626572206f66207468652067726f75702e2048652077617320736f2073746f6e65642074686174206865206d69737365642074686520696e7669746174696f6e20746f206a6f696e2074686520426f79732720436c75622e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/stonie_5e643a6289.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STONIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STONIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

