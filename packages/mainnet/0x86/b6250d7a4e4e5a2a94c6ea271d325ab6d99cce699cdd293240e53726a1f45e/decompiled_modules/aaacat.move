module 0x86b6250d7a4e4e5a2a94c6ea271d325ab6d99cce699cdd293240e53726a1f45e::aaacat {
    struct AAACAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAACAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAACAT>(arg0, 6, b"AAACAT", b"AAA CAT SUI", x"43616e27742073746f7020776f6e27742073746f7020287468696e6b696e672061626f75742053756929200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/AAA_CAT_SUI_e94f44c626.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAACAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAACAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

