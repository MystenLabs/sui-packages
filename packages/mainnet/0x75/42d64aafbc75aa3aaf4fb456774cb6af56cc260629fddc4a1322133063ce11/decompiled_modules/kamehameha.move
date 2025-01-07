module 0x7542d64aafbc75aa3aaf4fb456774cb6af56cc260629fddc4a1322133063ce11::kamehameha {
    struct KAMEHAMEHA has drop {
        dummy_field: bool,
    }

    fun init(arg0: KAMEHAMEHA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KAMEHAMEHA>(arg0, 6, b"KAMEHAMEHA", b"SUIYAN DOGE", b"You know Dbz, you know DOGE, meet SUIYAN DOGE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000009512_64fb378322.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KAMEHAMEHA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KAMEHAMEHA>>(v1);
    }

    // decompiled from Move bytecode v6
}

