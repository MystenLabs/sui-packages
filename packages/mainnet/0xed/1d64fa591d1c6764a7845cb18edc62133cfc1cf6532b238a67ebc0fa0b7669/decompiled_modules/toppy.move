module 0xed1d64fa591d1c6764a7845cb18edc62133cfc1cf6532b238a67ebc0fa0b7669::toppy {
    struct TOPPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOPPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOPPY>(arg0, 6, b"TOPPY", b"TOPPY SUI", b"I embrace independent thinking", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_05_09_01_40_50_75a7c356ad.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOPPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TOPPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

