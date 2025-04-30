module 0x7e635a508a8ceb1bda5f0c1c640a7fc9011324a6f99b561814d23a98f226bcf4::froko {
    struct FROKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: FROKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FROKO>(arg0, 6, b"FROKO", b"Froko", b"Froko on Sui. Realset frog, another story.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PP_e17cc867a1.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FROKO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FROKO>>(v1);
    }

    // decompiled from Move bytecode v6
}

