module 0xbbbc3184eb911dae242b7ebd92d91b29979f45ec483268a23de8366222882cfd::koala {
    struct KOALA has drop {
        dummy_field: bool,
    }

    fun init(arg0: KOALA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KOALA>(arg0, 6, b"KOALA", b"Sui Koala", b"SUI KOALA: THE SYMBOL OF LazIness", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/New_Project_2024_10_02_T202310_144_1d5efb2532.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KOALA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KOALA>>(v1);
    }

    // decompiled from Move bytecode v6
}

