module 0x42958e218369d4ffeffa57b986657c895affe3b3cfc006d5b01a6e7f6f4b6bf5::tog {
    struct TOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOG>(arg0, 6, b"TOG", b"Towel Dog", b"Dog Wrapped in Towel", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000007921_708d84f032.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

