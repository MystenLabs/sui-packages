module 0xf2fc1a1f751e067239ac0767e8bd7cde569f50f4cac1384101cae323f10f898b::aizen {
    struct AIZEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIZEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AIZEN>(arg0, 9, b"AIZEN", b"Irena Aizen", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmNVjJDePeGdcwpdGj3ruq7SgL67NKw2JawAZSpTdRyiZX")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<AIZEN>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AIZEN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIZEN>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

