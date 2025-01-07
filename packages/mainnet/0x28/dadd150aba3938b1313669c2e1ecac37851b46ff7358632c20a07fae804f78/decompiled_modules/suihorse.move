module 0x28dadd150aba3938b1313669c2e1ecac37851b46ff7358632c20a07fae804f78::suihorse {
    struct SUIHORSE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIHORSE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIHORSE>(arg0, 6, b"SUIHORSE", b"Sui Horse", b"SUIHORSE, once a fascinating sea creature, now swims upright in the SUI marketplace.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_02_18_31_29_854959e533_9e3e089516.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIHORSE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIHORSE>>(v1);
    }

    // decompiled from Move bytecode v6
}

