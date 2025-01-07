module 0xc070af050fe2e3f5e32069341ef99dc003c83dd278fe1e4125d2fbe805c82f79::skol {
    struct SKOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKOL>(arg0, 6, b"SKOL", b"SUIKOL", b"Impressive art... Community based token, will burn all dev wallet till this is done.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/c6363fcbb58c9393d89214f23d403759_a9c73876d8.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKOL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SKOL>>(v1);
    }

    // decompiled from Move bytecode v6
}

