module 0xbe63d67119aa31e41377dd1de5108563d7ddb1eb906afdf266d3df7c7b2f52cf::pepesui {
    struct PEPESUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPESUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPESUI>(arg0, 9, b"PEPESUI", b"Pepe SUI", b"Pepe on SUI token.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://assets.coingecko.com/coins/images/30128/large/pepesui.jpeg?1696529050")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PEPESUI>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPESUI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEPESUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

