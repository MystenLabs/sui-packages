module 0x1215cb93f9770920b99efd5d8ce1b71731f6ce800a1933db15f5221663fd54d2::loh {
    struct LOH has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<LOH>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<LOH>>(0x2::coin::mint<LOH>(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    fun init(arg0: LOH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOH>(arg0, 6, b"SMBL", b"Name", b"Description", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/N_N_D_D_N_D_N_D_d1b423d435.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LOH>>(v1);
    }

    // decompiled from Move bytecode v6
}

