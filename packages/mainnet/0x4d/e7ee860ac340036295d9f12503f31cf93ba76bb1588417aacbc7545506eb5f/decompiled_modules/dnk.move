module 0x4de7ee860ac340036295d9f12503f31cf93ba76bb1588417aacbc7545506eb5f::dnk {
    struct DNK has drop {
        dummy_field: bool,
    }

    fun init(arg0: DNK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DNK>(arg0, 6, b"DNK", b"donkey", b"we are donkeys", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"we are donket")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DNK>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DNK>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DNK>>(v1);
    }

    // decompiled from Move bytecode v6
}

