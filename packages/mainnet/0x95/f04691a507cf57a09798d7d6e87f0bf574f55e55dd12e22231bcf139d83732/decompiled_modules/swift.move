module 0x95f04691a507cf57a09798d7d6e87f0bf574f55e55dd12e22231bcf139d83732::swift {
    struct SWIFT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWIFT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWIFT>(arg0, 6, b"SWIFT", b"SWIFTPAW", b"Swiftpaw is the ultimate memecoin on the SUI blockchain, blending community spirit with playful adventure. Inspired by the quick and daring Swiftpaw character, this token aims to deliver fun and value to its holders.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/460050118_122154424112263711_7141379020474299253_n_da5b607f10.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWIFT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SWIFT>>(v1);
    }

    // decompiled from Move bytecode v6
}

