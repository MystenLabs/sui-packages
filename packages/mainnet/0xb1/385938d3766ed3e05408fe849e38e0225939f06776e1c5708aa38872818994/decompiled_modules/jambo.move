module 0xb1385938d3766ed3e05408fe849e38e0225939f06776e1c5708aa38872818994::jambo {
    struct JAMBO has drop {
        dummy_field: bool,
    }

    fun init(arg0: JAMBO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JAMBO>(arg0, 6, b"JAMBO", b"JAMBO ON SUI", b"HELLO, MAMBO JAMBO. WE BRING JAMBO ON SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/USEABLE_PIC_jpg_71adee7a68.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JAMBO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JAMBO>>(v1);
    }

    // decompiled from Move bytecode v6
}

