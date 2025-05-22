module 0xf5a49f57d89b812eface201194381d5c81b462f39b90b220a024750737ea5d4::govex {
    struct GOVEX has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOVEX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOVEX>(arg0, 9, b"GOVEX", b"Govex", b"The native token for the Govex Protocol.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.govex.ai/images/govex-icon.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GOVEX>(&mut v2, 750000000 * 0x1::u64::pow(10, 9), 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GOVEX>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOVEX>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

