module 0xb6ff6d7b7d21a062189cbdcb75821a1f686a613813bd02ec053f4eb592663a47::frug {
    struct FRUG has drop {
        dummy_field: bool,
    }

    fun init(arg0: FRUG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FRUG>(arg0, 6, b"FRUG", b"Frogglety", x"48692c2049276d2066726f67676c6574790a49276d206120646567656e2067616d626c65722074686174206c69766573206f6e207468652053756920626c6f636b636861696e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/l_3k54_B1_400x400_80b97dd0ec.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FRUG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FRUG>>(v1);
    }

    // decompiled from Move bytecode v6
}

