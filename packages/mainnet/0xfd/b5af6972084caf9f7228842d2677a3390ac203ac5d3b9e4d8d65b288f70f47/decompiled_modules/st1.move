module 0xfdb5af6972084caf9f7228842d2677a3390ac203ac5d3b9e4d8d65b288f70f47::st1 {
    struct ST1 has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<ST1>, arg1: 0x2::coin::Coin<ST1>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::burn<ST1>(arg0, arg1);
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<ST1>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<ST1>>(0x2::coin::mint<ST1>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: ST1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ST1>(arg0, 9, b"SUIDAOS TOKEN 1", b"ST1", b"Test DAO token description", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTbhnDgWMBc2Edo0UZhB3KBZSlvfDyxe8WMMQ&s")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ST1>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ST1>>(v0, @0x14e2c159e1028a7ff746408475abc56448052d3fc6cd6ce8487596b984dc8f3e);
    }

    // decompiled from Move bytecode v6
}

