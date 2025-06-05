module 0x2aaa9ac0ddbeb3a108ce0672a249d69ecdd1a34bbaf41cd95859de664071350a::prdt {
    struct PRDT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PRDT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PRDT>(arg0, 6, b"PRDT", b"PRDT Financce", b"Predict. Mine. Win. Join the first cross-chain DeFi prediction platform and start mining $PRDT tokens before launch!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/prdt_6aca2da190.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PRDT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PRDT>>(v1);
    }

    // decompiled from Move bytecode v6
}

