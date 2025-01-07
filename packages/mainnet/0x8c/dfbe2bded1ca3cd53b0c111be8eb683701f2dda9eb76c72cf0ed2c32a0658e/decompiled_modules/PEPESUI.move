module 0x8cdfbe2bded1ca3cd53b0c111be8eb683701f2dda9eb76c72cf0ed2c32a0658e::PEPESUI {
    struct PEPESUI has drop {
        dummy_field: bool,
    }

    entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<PEPESUI>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PEPESUI>>(0x2::coin::mint<PEPESUI>(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    fun init(arg0: PEPESUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPESUI>(arg0, 9, b"PEPE.sui", b"PEPE SUI", b"Pepe is taking over from the dogs and PEPE SUI will be the first bridge that will allow you to transfer your $PEPE.sui from the BSC network to the SUI network.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://pbs.twimg.com/profile_images/1649100092379480089/I8333KgA_400x400.jpg"))), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPESUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PEPESUI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

