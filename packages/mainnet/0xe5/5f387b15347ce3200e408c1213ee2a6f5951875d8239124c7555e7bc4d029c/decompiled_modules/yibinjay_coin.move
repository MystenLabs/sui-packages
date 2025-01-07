module 0xe55f387b15347ce3200e408c1213ee2a6f5951875d8239124c7555e7bc4d029c::yibinjay_coin {
    struct YIBINJAY_COIN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<YIBINJAY_COIN>, arg1: 0x2::coin::Coin<YIBINJAY_COIN>) {
        0x2::coin::burn<YIBINJAY_COIN>(arg0, arg1);
    }

    fun init(arg0: YIBINJAY_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YIBINJAY_COIN>(arg0, 9, b"YIBINJAY_COIN", b"YibinJay", b"this is my first virtual coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://avatars.githubusercontent.com/u/167294502")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YIBINJAY_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YIBINJAY_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<YIBINJAY_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<YIBINJAY_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

