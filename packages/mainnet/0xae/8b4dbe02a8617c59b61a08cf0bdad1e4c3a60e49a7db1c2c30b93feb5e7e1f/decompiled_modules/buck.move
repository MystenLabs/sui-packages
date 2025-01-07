module 0xae8b4dbe02a8617c59b61a08cf0bdad1e4c3a60e49a7db1c2c30b93feb5e7e1f::buck {
    struct BUCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUCK>(arg0, 6, b"BUCK", b"buck", b"buck doesnt give a fuck", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/buck_9056297058.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

