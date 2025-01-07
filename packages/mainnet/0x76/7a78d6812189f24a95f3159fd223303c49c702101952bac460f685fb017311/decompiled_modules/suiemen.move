module 0x767a78d6812189f24a95f3159fd223303c49c702101952bac460f685fb017311::suiemen {
    struct SUIEMEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIEMEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIEMEN>(arg0, 6, b"Suiemen", b"The Sperm", b"I'm Suiemen the sperm, swimmin on Sui. Calm, Collected, Seeding These Broads With Alpha Genetics. Diamond Handing  Until 100s of Millions.  ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suiemenlogo_1_663fa3cc39.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIEMEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIEMEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

