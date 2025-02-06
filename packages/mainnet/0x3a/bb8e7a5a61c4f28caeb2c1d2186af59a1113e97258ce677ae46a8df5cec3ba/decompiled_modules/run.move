module 0x3abb8e7a5a61c4f28caeb2c1d2186af59a1113e97258ce677ae46a8df5cec3ba::run {
    struct RUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: RUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RUN>(arg0, 9, b"run", b"run", b"run", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"run")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<RUN>(&mut v2, 1100000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RUN>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<RUN>>(v2);
    }

    // decompiled from Move bytecode v6
}

