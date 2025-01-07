module 0xe4f870d598682f2d06634451f9d05234e30a7d5e7e01489ed5b1901ddc66e89b::layla {
    struct LAYLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: LAYLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LAYLA>(arg0, 6, b"LAYLA", b"Layla on Sui", b"The ocean fairy from Winx has landed on the Sui Network! $LAYLA brings the magic of the tides and the power of the waves to the blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PP_1_6d7d828a32.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LAYLA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LAYLA>>(v1);
    }

    // decompiled from Move bytecode v6
}

