module 0x212ddb0d6c425cb0d89a5270cfeeb024b0d9c38b7c72f426844b79a4629160fb::sbt {
    struct SBT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBT>(arg0, 6, b"SBT", b"Sui Baby Tiger", b"Say hi to $SBT, the meme coin with an edge! SuiBabyTiger rewards holders automatically with every tradeso the longer you hold, the more you earn.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/R_Vu5_Hmar_400x400_88b190d0eb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SBT>>(v1);
    }

    // decompiled from Move bytecode v6
}

