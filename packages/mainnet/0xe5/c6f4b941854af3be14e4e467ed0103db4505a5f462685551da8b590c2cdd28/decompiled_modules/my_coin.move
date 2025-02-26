module 0xe5c6f4b941854af3be14e4e467ed0103db4505a5f462685551da8b590c2cdd28::my_coin {
    struct MY_COIN has drop {
        dummy_field: bool,
    }

    struct MyCoin has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<MY_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == @0xfbe99c31d90be3aedaec6f25f837eeb32665a19416c51856a2feab6dce50da99, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<MY_COIN>>(0x2::coin::mint<MY_COIN>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: MY_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MY_COIN>(arg0, 9, b"MYCOIN", b"My Coin", b"A custom coin for learning purposes", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MY_COIN>>(v0, @0xfbe99c31d90be3aedaec6f25f837eeb32665a19416c51856a2feab6dce50da99);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MY_COIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

