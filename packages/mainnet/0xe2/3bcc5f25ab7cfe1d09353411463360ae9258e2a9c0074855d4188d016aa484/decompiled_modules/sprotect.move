module 0xe23bcc5f25ab7cfe1d09353411463360ae9258e2a9c0074855d4188d016aa484::sprotect {
    struct SPROTECT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPROTECT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPROTECT>(arg0, 6, b"SPROTECT", b"Sui Guard Protection", b"$SPROTECT - is a safeguard that maintains stability and strength in the sui network.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_20250503_025748_X_83c22ac904.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPROTECT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPROTECT>>(v1);
    }

    // decompiled from Move bytecode v6
}

