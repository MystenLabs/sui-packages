module 0x550bbb28d1fcc94e32b45e64a5ce53132ce1a063297c24adfd7f02d7d9d4ee0d::jason {
    struct JASON has drop {
        dummy_field: bool,
    }

    fun init(arg0: JASON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JASON>(arg0, 6, b"JASON", b"Just a chill Jason", x"496d206a7573742061206368696c6c206775792c20657863657074206f6e204672696461792074686520313374682e204c657473206368617365207468697320757020746f203133206d696c6c696f6e206f7220656c736520496c6c2070726f6261626c79206a757374206861766520746f206b696c6c20796f752e200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Tak_berjudul7_20241213180454_c9853a5197.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JASON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JASON>>(v1);
    }

    // decompiled from Move bytecode v6
}

