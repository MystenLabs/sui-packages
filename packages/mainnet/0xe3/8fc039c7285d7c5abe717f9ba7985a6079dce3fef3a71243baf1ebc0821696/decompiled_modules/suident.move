module 0xe38fc039c7285d7c5abe717f9ba7985a6079dce3fef3a71243baf1ebc0821696::suident {
    struct SUIDENT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDENT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDENT>(arg0, 6, b"SUIDENT", b"TRIDENT of the SUI SEAS", b"$SUIDENT is a powerful token on Sui, inspired by the strength and precision of a trident. Like a trident striking in all directions, $SUIDENT empowers its holders to dominate the market with sharp, focused moves and unmatched control!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/TRIDENT_eddc355417.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDENT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIDENT>>(v1);
    }

    // decompiled from Move bytecode v6
}

