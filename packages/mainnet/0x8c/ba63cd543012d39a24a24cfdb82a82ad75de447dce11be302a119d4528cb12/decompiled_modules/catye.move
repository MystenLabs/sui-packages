module 0x8cba63cd543012d39a24a24cfdb82a82ad75de447dce11be302a119d4528cb12::catye {
    struct CATYE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATYE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATYE>(arg0, 6, b"CATYE", b"Yellow Cat on Sui", b"Just a yellow Cat on Sui Network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ddddddddddd3_fd2fae66fb.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATYE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATYE>>(v1);
    }

    // decompiled from Move bytecode v6
}

