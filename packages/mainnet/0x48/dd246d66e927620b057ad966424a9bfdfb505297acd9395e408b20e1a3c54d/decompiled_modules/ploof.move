module 0x48dd246d66e927620b057ad966424a9bfdfb505297acd9395e408b20e1a3c54d::ploof {
    struct PLOOF has drop {
        dummy_field: bool,
    }

    fun init(arg0: PLOOF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PLOOF>(arg0, 6, b"PLOOF", b"SuiPloof", b"Soft, squishy, and full of surprises.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_2024_12_16_052306705_c8a0c0ebcd.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PLOOF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PLOOF>>(v1);
    }

    // decompiled from Move bytecode v6
}

