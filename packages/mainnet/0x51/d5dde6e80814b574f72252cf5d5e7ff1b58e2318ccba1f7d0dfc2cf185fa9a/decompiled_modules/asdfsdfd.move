module 0x51d5dde6e80814b574f72252cf5d5e7ff1b58e2318ccba1f7d0dfc2cf185fa9a::asdfsdfd {
    struct ASDFSDFD has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<ASDFSDFD>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<ASDFSDFD>>(0x2::coin::mint<ASDFSDFD>(arg0, arg1 * 1000000000, arg3), arg2);
    }

    fun init(arg0: ASDFSDFD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASDFSDFD>(arg0, 9, b"ASDFSDFD", b"my coin", b"dfasdfasdf safsd fsf", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://plz.money/coin-icon.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<ASDFSDFD>>(0x2::coin::mint<ASDFSDFD>(&mut v2, 1 * 1000000000 / 100 * 1000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ASDFSDFD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASDFSDFD>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

