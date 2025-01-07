module 0x8d2e9bfb143c996e708173c182641a935b8c8e34772ef1d3c5e6507b6289d693::suii {
    struct SUII has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUII, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUII>(arg0, 6, b"Suii", b"Chinese Sui", b"From the clouds of the east, wealth will rain down you with Chinese Sui!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suiiii_af28948bc0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUII>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUII>>(v1);
    }

    // decompiled from Move bytecode v6
}

