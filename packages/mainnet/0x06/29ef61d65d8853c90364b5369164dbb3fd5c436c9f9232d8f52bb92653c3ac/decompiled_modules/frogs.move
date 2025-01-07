module 0x629ef61d65d8853c90364b5369164dbb3fd5c436c9f9232d8f52bb92653c3ac::frogs {
    struct FROGS has drop {
        dummy_field: bool,
    }

    fun init(arg0: FROGS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FROGS>(arg0, 6, b"FROGS", b"FROGS SUI", b"$FROGS ON SUI ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0x3e9c3dc19efe4271d1a65facfca55906045f7b08_f82ef77331.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FROGS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FROGS>>(v1);
    }

    // decompiled from Move bytecode v6
}

