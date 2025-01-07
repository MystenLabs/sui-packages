module 0x4b0b0e3824941098d8e32f1e5b24ae82bf698272d709a97154c483dd77b069a6::goddeng {
    struct GODDENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: GODDENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GODDENG>(arg0, 6, b"GODDENG", b"GOD DENG", x"596f75206d6973736564206f7574206f6e204d6f6f2044656e673f0a476f642044656e672121210a5468697320697320796f7572206c617374206368616e63652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/07_21f4558ccb.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GODDENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GODDENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

