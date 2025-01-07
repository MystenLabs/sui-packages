module 0x32a9aaa5bd0d5342eba696202fddeb4f571f80111c7c7d681f9efcdb3dcf9f48::suibank {
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

