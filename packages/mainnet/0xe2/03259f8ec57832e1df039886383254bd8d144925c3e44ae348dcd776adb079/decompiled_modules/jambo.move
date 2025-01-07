module 0xe203259f8ec57832e1df039886383254bd8d144925c3e44ae348dcd776adb079::jambo {
    struct JAMBO has drop {
        dummy_field: bool,
    }

    fun init(arg0: JAMBO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JAMBO>(arg0, 6, b"JAMBO", b"JAMBO ON SUI", b"HELLO, MAMBO JAMBO. WE BRING JAMBO ON SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/USEABLE_PIC_jpg_f5e962129e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JAMBO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JAMBO>>(v1);
    }

    // decompiled from Move bytecode v6
}

