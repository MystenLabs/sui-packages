module 0x8435bd0cdb3728a565f49cfc96d093416d0fd21766acf08ba5ec57b783ecaf78::weirdo {
    struct WEIRDO has drop {
        dummy_field: bool,
    }

    fun init(arg0: WEIRDO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WEIRDO>(arg0, 6, b"WEIRDO", b"WEIRDO ON SUI", b"First Weirdo on Sui. uS crypto degenerates (weirdos) are outcasts of society", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/660e50f55112dbca9805b425_IMAGE_2024_03_24_13_21_14_13_p_500_ebf4a17a3a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WEIRDO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WEIRDO>>(v1);
    }

    // decompiled from Move bytecode v6
}

