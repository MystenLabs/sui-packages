module 0x7200c969d52d2730c1bc9e620e3756082a6168b781a90819564843d08b76ebb6::suibank {
    struct SUIBANK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBANK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBANK>(arg0, 6, b"SUIBANK", b"Sui Bank", b"The vault of the Sui Network. $SUIBANK is where the big moves happen, storing and securing your digital wealth. Trust the bank, own the future!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PP_2_25094d23a4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBANK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIBANK>>(v1);
    }

    // decompiled from Move bytecode v6
}

