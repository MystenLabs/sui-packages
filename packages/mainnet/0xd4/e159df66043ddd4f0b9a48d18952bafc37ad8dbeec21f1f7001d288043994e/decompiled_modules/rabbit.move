module 0xd4e159df66043ddd4f0b9a48d18952bafc37ad8dbeec21f1f7001d288043994e::rabbit {
    struct RABBIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: RABBIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RABBIT>(arg0, 9, b"rbt", b"rabbit", b"jhadjkfhkdjhf", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://kappa-dev.sgp1.cdn.digitaloceanspaces.com/kappa-dev/coins/bbaad6b5-6043-49be-9a94-660f8dd5aad5.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RABBIT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RABBIT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

