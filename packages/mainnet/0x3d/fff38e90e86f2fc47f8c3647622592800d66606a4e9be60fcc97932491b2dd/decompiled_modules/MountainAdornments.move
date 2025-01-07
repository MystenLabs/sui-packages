module 0x3dfff38e90e86f2fc47f8c3647622592800d66606a4e9be60fcc97932491b2dd::MountainAdornments {
    struct MOUNTAINADORNMENTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOUNTAINADORNMENTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOUNTAINADORNMENTS>(arg0, 0, b"COS", b"Mountain Adornments", b"Celebration... the majesty... the gold temple where... where are you from?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Head_Mountain_Adornments_.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOUNTAINADORNMENTS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOUNTAINADORNMENTS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

