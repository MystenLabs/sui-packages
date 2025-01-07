module 0x2bcb399cc273f7970a9b719465e2ccf31bcf5e2566e7e01d98f40886affed6c0::crcl {
    struct CRCL has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRCL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRCL>(arg0, 6, b"CRCL", b"CRAZY CAMEL", x"0a5472656b6b696e67207468726f7567682074686520646573657274206f66206d656d65732c204372617a792043616d656c206272696e677320746865206f61736973206f66206761696e732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_2024_12_19_052648380_71dbe11c82.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRCL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CRCL>>(v1);
    }

    // decompiled from Move bytecode v6
}

