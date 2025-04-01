module 0x30586495029ebb0d644d14741af5453dbd71dbca3646813d62c9a11df19e4064::k76e {
    struct K76E has drop {
        dummy_field: bool,
    }

    fun init(arg0: K76E, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<K76E>(arg0, 9, b"K76E", b"m7r", b"hrtkyduf", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/617b2a078ee501317d1c3c94ecd13637blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<K76E>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<K76E>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

