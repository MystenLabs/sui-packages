module 0x880006f59420363f6416b9ac104fc99a737688eaeb5717b9f9f8a3e922f38632::RAT {
    struct RAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: RAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RAT>(arg0, 6, b"Rat Dance", b"RAT", b"Rat dancing to the beat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"ICoN_URL_STRING_PLACEHOLDER")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

