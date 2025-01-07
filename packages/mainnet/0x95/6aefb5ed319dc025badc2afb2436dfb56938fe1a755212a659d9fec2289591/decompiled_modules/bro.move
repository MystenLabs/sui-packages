module 0x956aefb5ed319dc025badc2afb2436dfb56938fe1a755212a659d9fec2289591::bro {
    struct BRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRO>(arg0, 9, b"BRO", b"BRO", b"SUI BRO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://futureby.info/wp-content/uploads/2023/08/sui.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BRO>(&mut v2, 21000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BRO>>(v1);
    }

    // decompiled from Move bytecode v6
}

