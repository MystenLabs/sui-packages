module 0x58ca19665eef76b05ebb918d5f143e8368fc9dd011ead85ea18e08d88f0ee773::osail_05sep2025_0900 {
    struct OSAIL_05SEP2025_0900 has drop {
        dummy_field: bool,
    }

    fun init(arg0: OSAIL_05SEP2025_0900, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OSAIL_05SEP2025_0900>(arg0, 6, b"oSAIL-05Sep2025-0900", b"oSAIL-05Sep2025-0900", b"Full Sail option token, expiration 05 Sep 2025 09:00:00 UTC", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://app.fullsail.finance/static_files/o_sail_coin.png"))), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OSAIL_05SEP2025_0900>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OSAIL_05SEP2025_0900>>(v1);
    }

    // decompiled from Move bytecode v6
}

