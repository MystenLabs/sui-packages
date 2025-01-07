module 0xa7b395b53e82f7d14dc0f6ab735b5cda73b2b766db999a99eada82462638989a::klaus {
    struct KLAUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: KLAUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KLAUS>(arg0, 6, b"Klaus", b"KlausOnSui", x"244b4c415553202d20546865206c656164696e67204d656d65636f696e206f6620746869732062756c6c2072756e2e0aefbbbf0a506570652073746172746564207468652032303233206d656d6520636f696e2072756e2077697468204d6174742066757269657320626f797320636c756220636861726163746572732e0aefbbbf0aefbbbf244b4c415553206973207374617274696e672074686520323032342f32303235206d656d6520636f696e2062756c6c2072756e20776974682053657468204d61634661726c616e6520636861726163746572732eefbbbf", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730997739956.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KLAUS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KLAUS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

