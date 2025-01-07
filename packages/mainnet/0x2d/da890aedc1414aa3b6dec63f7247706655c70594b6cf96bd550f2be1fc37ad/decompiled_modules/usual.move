module 0x2dda890aedc1414aa3b6dec63f7247706655c70594b6cf96bd550f2be1fc37ad::usual {
    struct USUAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: USUAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USUAL>(arg0, 6, b"USUAL", b"USUAL ON SUI", b"USUAL ON SOL", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/usual_c4de82d833.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USUAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<USUAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

