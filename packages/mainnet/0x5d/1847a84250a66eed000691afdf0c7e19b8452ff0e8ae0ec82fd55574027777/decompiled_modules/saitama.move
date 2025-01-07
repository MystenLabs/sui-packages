module 0x5d1847a84250a66eed000691afdf0c7e19b8452ff0e8ae0ec82fd55574027777::saitama {
    struct SAITAMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAITAMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAITAMA>(arg0, 6, b"SAITAMA", b"Saitama on Sui", b"Saitam'a Blockchain Evolution in Sui introduces a groundbreaking technology known as SUITAMA that is set to revolutionize the dig", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_02_21_36_03_50afbcb10b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAITAMA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SAITAMA>>(v1);
    }

    // decompiled from Move bytecode v6
}

