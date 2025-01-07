module 0x8ee254147743216fafc28c8b6b60b1f90552dbf488becf37f8b6e9451495059::aaadodo {
    struct AAADODO has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAADODO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAADODO>(arg0, 6, b"AAADODO", b"aaaDODO", b"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaDodo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_04_01_36_58_9a4c0054b3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAADODO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAADODO>>(v1);
    }

    // decompiled from Move bytecode v6
}

