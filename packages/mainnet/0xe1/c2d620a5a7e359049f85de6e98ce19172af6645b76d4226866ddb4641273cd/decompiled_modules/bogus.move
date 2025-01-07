module 0xe1c2d620a5a7e359049f85de6e98ce19172af6645b76d4226866ddb4641273cd::bogus {
    struct BOGUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOGUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOGUS>(arg0, 6, b"BOGUS", b"BOGUS SUI", b"A collective celebrating the wonderful absurdity of all things crypto", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/k_VX_7_OI_8y_400x400_37a8e583f6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOGUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOGUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

