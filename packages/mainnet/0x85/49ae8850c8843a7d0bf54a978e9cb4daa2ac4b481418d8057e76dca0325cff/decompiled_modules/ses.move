module 0x8549ae8850c8843a7d0bf54a978e9cb4daa2ac4b481418d8057e76dca0325cff::ses {
    struct SES has drop {
        dummy_field: bool,
    }

    fun init(arg0: SES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SES>(arg0, 6, b"SES", b"Sui electric shrimp", b"for fun, lol", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/11_4879965250.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SES>>(v1);
    }

    // decompiled from Move bytecode v6
}

