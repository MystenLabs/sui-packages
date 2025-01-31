module 0xac8ce5720ee081c6f25e6e0922371d6507249b8fd12c9ccebc305e9f5f5571bb::common_coin {
    struct COMMON_COIN has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<COMMON_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<COMMON_COIN>>(0x2::coin::mint<COMMON_COIN>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: COMMON_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COMMON_COIN>(arg0, 6, b"Glump", b"GLUMP", b"description", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://movepump.com/_next/image?url=https%3A%2F%2Fapi.movepump.com%2Fuploads%2FFighting_32_975f363710.png&w=640&q=75"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COMMON_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COMMON_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

