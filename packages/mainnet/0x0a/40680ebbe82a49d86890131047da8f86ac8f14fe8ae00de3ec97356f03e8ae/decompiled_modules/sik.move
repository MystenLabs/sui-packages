module 0xa40680ebbe82a49d86890131047da8f86ac8f14fe8ae00de3ec97356f03e8ae::sik {
    struct SIK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIK>(arg0, 6, b"SIK", b"Sk", b"skkk", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bottom_c42c3c9a10.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SIK>>(v1);
    }

    // decompiled from Move bytecode v6
}

