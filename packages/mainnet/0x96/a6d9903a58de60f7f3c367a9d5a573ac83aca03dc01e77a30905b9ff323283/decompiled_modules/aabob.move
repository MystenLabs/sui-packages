module 0x96a6d9903a58de60f7f3c367a9d5a573ac83aca03dc01e77a30905b9ff323283::aabob {
    struct AABOB has drop {
        dummy_field: bool,
    }

    fun init(arg0: AABOB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AABOB>(arg0, 6, b"AABOB", b"aaa spongebob", b"Can't stop won't stop (thinking about Sui)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0933_6386a6eedd.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AABOB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AABOB>>(v1);
    }

    // decompiled from Move bytecode v6
}

