module 0x9d815a361c223a77e3784bc550c5f3c84f6b360897829e40e5afd749eceaf2b0::FormofOpyaansKin {
    struct FORMOFOPYAANSKIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: FORMOFOPYAANSKIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FORMOFOPYAANSKIN>(arg0, 0, b"COS", b"Form of Opyaan's Kin ", b"Whether or not you choose to follow... you are forever one with the Opyaan...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Body_Form_of_Opyaan's_Kin.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FORMOFOPYAANSKIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FORMOFOPYAANSKIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

