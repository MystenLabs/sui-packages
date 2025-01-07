module 0xd9d8f0056fac13e2dae6e3587df06d0a8f54ea86a49d7ea30f1eabc26d5b8824::suimurf {
    struct SUIMURF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMURF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMURF>(arg0, 6, b"SUIMURF", b"Smurf on Sui", b"$SUIMURF brings a splash of fun to the Sui Network.  Get smurfy with it!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PP_1_24_256a6f0e0b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMURF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMURF>>(v1);
    }

    // decompiled from Move bytecode v6
}

