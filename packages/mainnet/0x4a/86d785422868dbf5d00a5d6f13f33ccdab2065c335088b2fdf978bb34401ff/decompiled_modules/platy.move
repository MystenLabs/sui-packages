module 0x4a86d785422868dbf5d00a5d6f13f33ccdab2065c335088b2fdf978bb34401ff::platy {
    struct PLATY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PLATY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PLATY>(arg0, 6, b"PLATY", b"sui platy", x"54686520706c617479707573206465736572766573206120706c61636520696e207468652063727970746f20776f726c64200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/5810187417242683043_a085622b81.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PLATY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PLATY>>(v1);
    }

    // decompiled from Move bytecode v6
}

