module 0xd191d6dc2f6fbe910153e52a595f928de906225fba9f38a9049c13b7bdef81d7::slup {
    struct SLUP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLUP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLUP>(arg0, 6, b"SLUP", b"SLUP SUI", b"$SLUP This is a collection from my childhood with my favourite hero", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_06_06_18_37_24_3f4496405f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLUP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SLUP>>(v1);
    }

    // decompiled from Move bytecode v6
}

