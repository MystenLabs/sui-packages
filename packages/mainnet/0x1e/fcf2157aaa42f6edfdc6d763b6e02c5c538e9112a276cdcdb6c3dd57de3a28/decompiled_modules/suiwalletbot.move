module 0x1efcf2157aaa42f6edfdc6d763b6e02c5c538e9112a276cdcdb6c3dd57de3a28::suiwalletbot {
    struct SUIWALLETBOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIWALLETBOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIWALLETBOT>(arg0, 6, b"SuiWalletBot", b"@SuiWalletBot", x"5375692057616c6c657420426f74206f6e2054656c656772616d200a0a4053756957616c6c6574426f745f626f74", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/water_drop2568_logowik_com_0b66171440.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIWALLETBOT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIWALLETBOT>>(v1);
    }

    // decompiled from Move bytecode v6
}

