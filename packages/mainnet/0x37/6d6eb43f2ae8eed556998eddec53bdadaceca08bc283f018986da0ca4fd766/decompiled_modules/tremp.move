module 0x376d6eb43f2ae8eed556998eddec53bdadaceca08bc283f018986da0ca4fd766::tremp {
    struct TREMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: TREMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TREMP>(arg0, 6, b"TREMP", b"Doland Tremp", b"Solana had Boden, SUI has $TREMP... Doland Tremp for President of the United States of America 2024!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731424734697.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TREMP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TREMP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

