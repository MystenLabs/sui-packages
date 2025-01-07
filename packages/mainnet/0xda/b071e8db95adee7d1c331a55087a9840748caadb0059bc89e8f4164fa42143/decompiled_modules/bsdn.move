module 0xdab071e8db95adee7d1c331a55087a9840748caadb0059bc89e8f4164fa42143::bsdn {
    struct BSDN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BSDN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BSDN>(arg0, 6, b"BSDN", b"Based President", b"SUI based president", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/trump_cbaa7a56a8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BSDN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BSDN>>(v1);
    }

    // decompiled from Move bytecode v6
}

