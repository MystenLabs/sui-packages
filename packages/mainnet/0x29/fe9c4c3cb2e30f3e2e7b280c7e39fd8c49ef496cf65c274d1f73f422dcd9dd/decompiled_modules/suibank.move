module 0x29fe9c4c3cb2e30f3e2e7b280c7e39fd8c49ef496cf65c274d1f73f422dcd9dd::suibank {
    struct SUIBANK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBANK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBANK>(arg0, 6, b"SUIBANK", b"Sui Bank", b"The vault of the Sui Network. The vault of the Sui Network. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PP_2_674ad4edee.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBANK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIBANK>>(v1);
    }

    // decompiled from Move bytecode v6
}

