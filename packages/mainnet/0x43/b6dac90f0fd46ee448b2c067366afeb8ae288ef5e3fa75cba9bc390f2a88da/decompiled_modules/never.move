module 0x43b6dac90f0fd46ee448b2c067366afeb8ae288ef5e3fa75cba9bc390f2a88da::never {
    struct NEVER has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEVER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEVER>(arg0, 6, b"NEVER", b"never selling", b"we will never sell.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/G_Uyabsvao_A_Awh_BT_548b5e05d6.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEVER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NEVER>>(v1);
    }

    // decompiled from Move bytecode v6
}

