module 0x1f373f06b526e9d18683dbe2c58cb746829f00cf1bff170ccadae5a624c6cb89::messi {
    struct MESSI has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<MESSI>, arg1: 0x2::coin::Coin<MESSI>) {
        0x2::coin::burn<MESSI>(arg0, arg1);
    }

    public entry fun custom_burn(arg0: &mut 0x2::coin::TreasuryCap<MESSI>, arg1: &mut 0x2::coin::Coin<MESSI>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::burn<MESSI>(arg0, 0x2::coin::split<MESSI>(arg1, arg2, arg3));
    }

    fun init(arg0: MESSI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MESSI>(arg0, 6, b"MESSI", b"MESSI", b"MESSI Meme on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://mensfolio.vn/wp-content/uploads/2022/12/09b364a5-fc2b-4d63-a7a1-6153de70e3e5.jpg"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MESSI>(&mut v2, 314000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MESSI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MESSI>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

