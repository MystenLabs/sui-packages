module 0xcd368dbf1e19e51e9fd727bb7de8afc45e55939db5603de209ea087de431150e::odi {
    struct ODI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ODI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ODI>(arg0, 6, b"ODI", b"Toadies", b"Best dog in the world", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/toadiestoken_e8ce1ee8cf.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ODI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ODI>>(v1);
    }

    // decompiled from Move bytecode v6
}

