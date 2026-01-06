module 0xb5b71207e67dccf2e044297abb4dec3bdca3a92e46aebc0edf156ab152d379b4::ers {
    struct ERS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ERS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ERS>(arg0, 6, b"Ers", b"Erbe Space", b"You need rich? Same with me ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000764214_4e7a437598.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ERS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ERS>>(v1);
    }

    // decompiled from Move bytecode v6
}

