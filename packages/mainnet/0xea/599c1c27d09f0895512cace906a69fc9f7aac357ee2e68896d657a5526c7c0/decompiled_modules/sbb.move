module 0xea599c1c27d09f0895512cace906a69fc9f7aac357ee2e68896d657a5526c7c0::sbb {
    struct SBB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBB>(arg0, 6, b"SBB", b"SUI Blue Barney", b"Barney is a dinosaur. From our imagination, And when he's tall, he's what we call A dinosaur sensation ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_06_16_23_30_20_b2c6d0e9c9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SBB>>(v1);
    }

    // decompiled from Move bytecode v6
}

