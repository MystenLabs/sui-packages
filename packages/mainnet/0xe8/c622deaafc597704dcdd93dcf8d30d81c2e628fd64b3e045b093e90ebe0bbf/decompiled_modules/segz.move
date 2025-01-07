module 0xe8c622deaafc597704dcdd93dcf8d30d81c2e628fd64b3e045b093e90ebe0bbf::segz {
    struct SEGZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEGZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEGZ>(arg0, 9, b"SEGZ", b"shadrach ", b"I am one of a kind ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e7b20fb5-fe68-40b5-aefa-396933e673bb.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEGZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SEGZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

