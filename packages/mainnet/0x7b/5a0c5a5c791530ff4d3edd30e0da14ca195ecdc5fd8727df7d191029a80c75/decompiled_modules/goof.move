module 0x7b5a0c5a5c791530ff4d3edd30e0da14ca195ecdc5fd8727df7d191029a80c75::goof {
    struct GOOF has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOOF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOOF>(arg0, 6, b"GOOF", b"Greatest Fisherman Of The Sui Ocean", b"The greatest fisherman of the @suinetwork ocean is ready to haul $GOOF to the top! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Sf_Y01_K6_C_400x400_1dcc96017f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOOF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOOF>>(v1);
    }

    // decompiled from Move bytecode v6
}

