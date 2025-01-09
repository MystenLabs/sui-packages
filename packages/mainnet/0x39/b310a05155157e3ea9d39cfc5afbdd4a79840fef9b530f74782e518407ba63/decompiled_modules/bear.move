module 0x39b310a05155157e3ea9d39cfc5afbdd4a79840fef9b530f74782e518407ba63::bear {
    struct BEAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEAR>(arg0, 6, b"BEAR", b"SUICEBEAR", b"The cutest hippo on SUI, bringing hippo to the world of memes", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000198588_b4b5ec2187.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BEAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

