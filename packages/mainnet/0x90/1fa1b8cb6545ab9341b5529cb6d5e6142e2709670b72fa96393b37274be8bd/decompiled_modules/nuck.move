module 0x901fa1b8cb6545ab9341b5529cb6d5e6142e2709670b72fa96393b37274be8bd::nuck {
    struct NUCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: NUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NUCK>(arg0, 6, b"NUCK", b"NUCK SUI", b"Popular meme nuck finds da wae on Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_05_09_07_18_15_5c679e809a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NUCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NUCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

