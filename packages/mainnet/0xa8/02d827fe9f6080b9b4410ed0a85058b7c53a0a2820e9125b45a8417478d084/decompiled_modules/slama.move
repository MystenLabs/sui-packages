module 0xa802d827fe9f6080b9b4410ed0a85058b7c53a0a2820e9125b45a8417478d084::slama {
    struct SLAMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLAMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLAMA>(arg0, 6, b"SLAMA", b"Suillama", b"New chart pattern spotted in the sea of sui. SLAMA IS THE NEW BREAKOUT INDICATOR!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/slama_f76bc6d99d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLAMA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SLAMA>>(v1);
    }

    // decompiled from Move bytecode v6
}

