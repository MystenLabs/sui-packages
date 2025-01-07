module 0x52dc35900dd9539dfb73e7eae1d88ac425ad89e1ad8c0d28af4008e47e16d0bc::monkey {
    struct MONKEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MONKEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MONKEY>(arg0, 6, b"MONKEY", b"Nasalis", x"4e6173616c6973202d205468652066756e6e69657374206d6f6e6b657920657665722e20536f6f6e206f6e202453554920626c6f636b636861696e2e0a4e6f20726f61646d617021204e6f207765627369746521204a757374206d656d65", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730991524198.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MONKEY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MONKEY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

