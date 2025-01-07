module 0xdd39084e0ee047635dd52852c0be100ed00256ad2f0161b44d36b7397031cf01::cit {
    struct CIT has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<CIT>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<CIT>>(0x2::coin::mint<CIT>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: CIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CIT>(arg0, 6, b"CIT", b"CIT Coin", b"CIT is the native token of Crypto Invest Terminal.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://hn6zlnf4reolilkbg7e2jgloogpfnzfnm2gp56efvq6hrv7752ia.arweave.net/O32VtLyJHLQtQTfJpJlucZ5W5K1mjP74haw8eNf_7pA")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CIT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CIT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

