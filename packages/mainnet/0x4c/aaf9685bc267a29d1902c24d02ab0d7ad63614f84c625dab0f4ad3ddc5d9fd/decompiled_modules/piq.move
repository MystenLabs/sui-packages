module 0x4caaf9685bc267a29d1902c24d02ab0d7ad63614f84c625dab0f4ad3ddc5d9fd::piq {
    struct PIQ has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIQ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIQ>(arg0, 6, b"PIQ", b"PigeonToken", b"pigeon quest WORLD", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ru2_I9_SA_400x400_2549cd2c9d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIQ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PIQ>>(v1);
    }

    // decompiled from Move bytecode v6
}

