module 0xa743293ae4a22816a1d62a6f887da7432172be71461595e7c0fbc7dcc3eed944::mooshi {
    struct MOOSHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOOSHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOOSHI>(arg0, 6, b"MOOSHI", b"MOOSHI SUISHI", b"This little cutie patootie got rugged on Solana so he wandered around sad and lonely until he found a new happy home on $SUI ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000016557_dd0b29bb10.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOOSHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOOSHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

