module 0xfaf411598030cee935520d86b20cb47d3fa7a4d33f6018fb439d632bc42585a7::sui143 {
    struct SUI143 has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUI143, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUI143>(arg0, 6, b"Sui143", b"143", b"Im just a cat that loves all things Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1341_9bf05c9bc7.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUI143>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUI143>>(v1);
    }

    // decompiled from Move bytecode v6
}

