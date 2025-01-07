module 0xf2fdcc69ab3aaacb7d71c24468e3991bb91810354ba291cb32538919da3d0ba6::suimici {
    struct SUIMICI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMICI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMICI>(arg0, 6, b"Suimici", b"mici", x"746865206d6f7374206d656d6561626c6520636174206f6e2074686520696e7465726e65740a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/30_bc93cd562c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMICI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMICI>>(v1);
    }

    // decompiled from Move bytecode v6
}

