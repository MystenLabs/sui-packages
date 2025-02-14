module 0x5dfa76d19b043ad4622414750990e673d9327c15c5e0f6cee30096fd3cde83d6::sht5 {
    struct SHT5 has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHT5, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHT5>(arg0, 6, b"Sht5", b"Shortist", b"I started with five dollars and am building the capital to buy a whole bitcoin!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1739528117495.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHT5>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHT5>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

