module 0x4e8b53337db295eae62a380815c4be24b9c17ca2bb850e784db657018c9bb73d::bnb {
    struct BNB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BNB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BNB>(arg0, 6, b"BNB", b"BINANCE", b"BnB BnB  BnB BnB BnB  BnB BnB BnB  BnB BnB BnB  BnBBnB BnB  BnB", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000004431_ebde68ead7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BNB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BNB>>(v1);
    }

    // decompiled from Move bytecode v6
}

