module 0x66980c68b397f8929cc90b007c94708a03332a3151b7f292e64d18938db0d9e7::side {
    struct SIDE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIDE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIDE>(arg0, 6, b"SIDE", b"SUI SIDE", b"SUI SIDE ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Sui_Side_Logo_3_6aa85ea09b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIDE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SIDE>>(v1);
    }

    // decompiled from Move bytecode v6
}

