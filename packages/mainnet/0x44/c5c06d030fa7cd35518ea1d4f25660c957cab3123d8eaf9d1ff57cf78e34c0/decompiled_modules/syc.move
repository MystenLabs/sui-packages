module 0x44c5c06d030fa7cd35518ea1d4f25660c957cab3123d8eaf9d1ff57cf78e34c0::syc {
    struct SYC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SYC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SYC>(arg0, 6, b"SYC", b"SUI YACHT CLUB", b"Are u ready?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_07_20_56_19_66ee4492e5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SYC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SYC>>(v1);
    }

    // decompiled from Move bytecode v6
}

