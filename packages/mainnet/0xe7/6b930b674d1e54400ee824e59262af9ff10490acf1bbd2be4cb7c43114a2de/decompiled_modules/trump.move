module 0xe76b930b674d1e54400ee824e59262af9ff10490acf1bbd2be4cb7c43114a2de::trump {
    struct TRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMP>(arg0, 6, b"TRUMP", b"TRUMP OFFICIAL SUI", x"4120436f6d6d756e6974792043656c6562726174696e6720436f7572616765202620537472656e6774680a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1737186801466.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRUMP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

