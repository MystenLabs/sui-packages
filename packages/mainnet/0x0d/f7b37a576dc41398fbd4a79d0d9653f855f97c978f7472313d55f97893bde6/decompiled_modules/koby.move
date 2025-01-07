module 0xdf7b37a576dc41398fbd4a79d0d9653f855f97c978f7472313d55f97893bde6::koby {
    struct KOBY has drop {
        dummy_field: bool,
    }

    fun init(arg0: KOBY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KOBY>(arg0, 6, b"KOBY", b"BLUE KOBY", b"The King is here $KOBY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3702_4097bc7ff0.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KOBY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KOBY>>(v1);
    }

    // decompiled from Move bytecode v6
}

