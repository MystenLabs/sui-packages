module 0x8c5954582df19e015a05125e5793ecf793257d08813ddb75429ae05e49a104f8::pika {
    struct PIKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIKA>(arg0, 6, b"PIKA", b"PIKASUI", b"PIKACHU ON SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigazxtfwbuhyi67yqxkmefnq6lpcqzv7keme4wkjjnwyyvkwos7jy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIKA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PIKA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

