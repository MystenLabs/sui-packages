module 0xd2a9afaf2bcc6feef707de427abf40ef672add5752f8bf4d2a7690b2564404ff::b_tato {
    struct B_TATO has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_TATO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_TATO>(arg0, 9, b"bTATO", b"bToken TATO", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_TATO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_TATO>>(v1);
    }

    // decompiled from Move bytecode v6
}

