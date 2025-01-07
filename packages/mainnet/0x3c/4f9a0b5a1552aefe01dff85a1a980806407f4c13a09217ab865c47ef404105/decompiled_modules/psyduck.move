module 0x3c4f9a0b5a1552aefe01dff85a1a980806407f4c13a09217ab865c47ef404105::psyduck {
    struct PSYDUCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: PSYDUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PSYDUCK>(arg0, 6, b"PSYDUCK", b"SUIPSYDUCK", b"PSYDUCK is constantly stunned by his headache and wants to calm down in SUI ocean.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PSYDUCK_SUI_82c6dee37b.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PSYDUCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PSYDUCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

