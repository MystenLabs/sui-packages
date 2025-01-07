module 0xf958027d12e538dcef70494d3062294ce859ad404d6cdb0b306e3108ea09cea0::xmas {
    struct XMAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: XMAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XMAS>(arg0, 6, b"Xmas", b"Christmas", x"4368726973746d6173206665737469766520746f6b656e730a4920646f6e277420646f20616e7920706172746963756c617220616374697669746965732c20736f20706c65617365206c65617665206d6520616c6f6e652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1734059697906.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XMAS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XMAS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

