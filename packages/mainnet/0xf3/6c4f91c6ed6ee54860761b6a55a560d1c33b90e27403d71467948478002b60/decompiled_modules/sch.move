module 0xf36c4f91c6ed6ee54860761b6a55a560d1c33b90e27403d71467948478002b60::sch {
    struct SCH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCH>(arg0, 6, b"SCH", b"such", b"most solluable for transection", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a406babaf4d4b0b50f7de90449d820a4_e749872f52.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCH>>(v1);
    }

    // decompiled from Move bytecode v6
}

