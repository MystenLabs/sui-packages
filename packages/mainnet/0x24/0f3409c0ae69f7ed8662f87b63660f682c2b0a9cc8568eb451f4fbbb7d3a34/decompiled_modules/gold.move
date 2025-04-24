module 0x240f3409c0ae69f7ed8662f87b63660f682c2b0a9cc8568eb451f4fbbb7d3a34::gold {
    struct GOLD has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOLD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOLD>(arg0, 6, b"Vayne", b"Vayne on Sui", b"Vayne slayer three star on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GOLD>>(v1);
        0x2::coin::mint_and_transfer<GOLD>(&mut v2, 1000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOLD>>(v2, 0x2::tx_context::sender(arg1));
    }

    public(friend) fun mint(arg0: &mut 0x2::coin::TreasuryCap<GOLD>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<GOLD>(arg0, arg2, arg1, arg3);
    }

    // decompiled from Move bytecode v6
}

