module 0x537aeba0337e449ee36849057b3a46f87ab58581452f1c4dd3fc25834cd35349::gang {
    struct GANG has drop {
        dummy_field: bool,
    }

    fun init(arg0: GANG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GANG>(arg0, 6, b"GANG", b"THUG LIFE", b"Thug life ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/gang_1fffc8d6d8.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GANG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GANG>>(v1);
    }

    // decompiled from Move bytecode v6
}

