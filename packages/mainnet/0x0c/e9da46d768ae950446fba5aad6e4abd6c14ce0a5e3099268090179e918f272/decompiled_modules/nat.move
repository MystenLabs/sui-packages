module 0xce9da46d768ae950446fba5aad6e4abd6c14ce0a5e3099268090179e918f272::nat {
    struct NAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: NAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NAT>(arg0, 9, b"NAT", b"NATURE2025", b"NATURE 2025", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/ce780681d07821e0d17593daceedbeafblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NAT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NAT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

