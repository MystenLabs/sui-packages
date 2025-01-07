module 0xfd935be072842d08b5f8793a49e4a61bb5fc6bd7c5b62df1ee55b7b6015562::achi {
    struct ACHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ACHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ACHI>(arg0, 6, b"ACHI", b"ACHI DOG", x"20414348490a0a54686520446f6720426568696e642057696620200a0a496e74726f647563696e6720244143484920546865204a6170616e6573652048616368696b6f20646f672072656e6f776e656420666f722068697320657863657074696f6e616c206c6f79616c74792c206f7220626574746572206b6e6f776e2066726f6d202457494620746865206d6f73742061646f7261626c6520646f6720696e2074686520776f726c642120", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ACHI_2f21982ad3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ACHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ACHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

