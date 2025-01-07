module 0xdcbbaba1522af707f824835d2532f81109c5f9e4ce51a92761b6dd067dd08fdd::watergun {
    struct WATERGUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: WATERGUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WATERGUN>(arg0, 6, b"Watergun", b"Sui Watergun", b"Ready, aim, splash! Sui $WATERGUN brings some playful chaos to Sui network.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Watergun_cf032ad5a5.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WATERGUN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WATERGUN>>(v1);
    }

    // decompiled from Move bytecode v6
}

