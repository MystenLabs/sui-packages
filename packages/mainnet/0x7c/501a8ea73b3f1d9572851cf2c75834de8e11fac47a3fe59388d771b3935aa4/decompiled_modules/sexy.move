module 0x7c501a8ea73b3f1d9572851cf2c75834de8e11fac47a3fe59388d771b3935aa4::sexy {
    struct SEXY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEXY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEXY>(arg0, 6, b"SEXY", b"Siren on Sui", x"53657869657374204d65726d616964206f6e205375690a0a4669727374206e6f6e20736f6369616c73206d6f766572206f6e205355492e0a0a4c697374656e20746f20746865206d757369632e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_23_14_49_27_d852aa5c0d.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEXY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SEXY>>(v1);
    }

    // decompiled from Move bytecode v6
}

