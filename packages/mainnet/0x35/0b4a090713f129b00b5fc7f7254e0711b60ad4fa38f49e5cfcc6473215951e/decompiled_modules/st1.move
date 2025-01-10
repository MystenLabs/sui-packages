module 0x350b4a090713f129b00b5fc7f7254e0711b60ad4fa38f49e5cfcc6473215951e::st1 {
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
        let (v0, v1) = 0x2::coin::create_currency<ST1>(arg0, 9, b"Test DAO Token 2", b"ST2", b"Test DAO token description 2", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://storage.googleapis.com/raidenx-no-cors/token-icons/pepe-scream.gif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ST1>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ST1>>(v0, @0x47cce5591186762aee1ed07eccdc9dafda922470a3ec2bf2138bf4ac532a4073);
    }

    // decompiled from Move bytecode v6
}

