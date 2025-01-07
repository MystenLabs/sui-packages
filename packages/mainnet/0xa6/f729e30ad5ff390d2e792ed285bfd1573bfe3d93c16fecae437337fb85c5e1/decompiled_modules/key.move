module 0xa6f729e30ad5ff390d2e792ed285bfd1573bfe3d93c16fecae437337fb85c5e1::key {
    struct KEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: KEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KEY>(arg0, 6, b"Key", b"Keyaru", b"Keyaru will heal da world", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1062518kk_d588f3acb8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KEY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KEY>>(v1);
    }

    // decompiled from Move bytecode v6
}

