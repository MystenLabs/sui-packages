module 0x7fbeb5647966279aee8e0e58e439b5eaeb0824045331b69305a5ee64f0e96bab::smilingdog {
    struct SMILINGDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMILINGDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMILINGDOG>(arg0, 6, b"Smilingdog", b"SDOG", b"This is a dog that loves to laugh", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_6490_a75928f3d7.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMILINGDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMILINGDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

