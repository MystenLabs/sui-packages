module 0xad3902967a45f75df321166dd9073d23a6b49f960bd5f6e15107a59dc1d0cc9e::soodeng {
    struct SOODENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOODENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOODENG>(arg0, 6, b"SOODENG", b"SOODENG ON SUI", b"FIRST SOODENG ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/soodeng_cde658c189.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOODENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOODENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

