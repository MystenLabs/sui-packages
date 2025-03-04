module 0xad0e20a2895373cd17304af515820dcdf6d9bac63098a6a94e1c42c017741527::asdg {
    struct ASDG has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASDG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASDG>(arg0, 9, b"ASDG", b"AsdgToken", b"A new token on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ASDG>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASDG>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ASDG>>(v1);
    }

    // decompiled from Move bytecode v6
}

