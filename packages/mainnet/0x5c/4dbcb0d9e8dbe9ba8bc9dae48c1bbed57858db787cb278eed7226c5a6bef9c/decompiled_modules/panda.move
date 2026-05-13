module 0x5c4dbcb0d9e8dbe9ba8bc9dae48c1bbed57858db787cb278eed7226c5a6bef9c::panda {
    struct PANDA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PANDA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PANDA>(arg0, 9, b"PANDA", b"Panda Test", b"https://gateway.pinata.cloud/ipfs/QmP84TeZNmn7C9hPir1LauF9tzsUpZ5jfEbbF7uBWzXYE3", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.pinata.cloud/ipfs/Qmei5R6HaJfF3WmQB3Apc5mQ4KYbZKfwHdQaCGG3WPXMuQ")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PANDA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PANDA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

