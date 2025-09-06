module 0x23c90eeb345b3d2fa9d06c5e512e6f98cc756942112dd0bd0be716b4be778247::osail_04sep2025_0900 {
    struct OSAIL_04SEP2025_0900 has drop {
        dummy_field: bool,
    }

    fun init(arg0: OSAIL_04SEP2025_0900, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OSAIL_04SEP2025_0900>(arg0, 6, b"oSAIL-04Sep2025-0900", b"oSAIL-04Sep2025-0900", b"Full Sail option token, expiration 04 Sep 2025 09:00:00 UTC", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://app.fullsail.finance/static_files/o_sail_coin.png"))), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OSAIL_04SEP2025_0900>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OSAIL_04SEP2025_0900>>(v1);
    }

    // decompiled from Move bytecode v6
}

