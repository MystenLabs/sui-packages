module 0x8475836110da1ffb4e880e8a121f9fef184147e23c268736528671a44066a392::suioki {
    struct SUIOKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIOKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIOKI>(arg0, 6, b"SUIOKI", b"Suioki", b"$SUIOKI, Sui Floki ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_9648_2603c81891.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIOKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIOKI>>(v1);
    }

    // decompiled from Move bytecode v6
}

