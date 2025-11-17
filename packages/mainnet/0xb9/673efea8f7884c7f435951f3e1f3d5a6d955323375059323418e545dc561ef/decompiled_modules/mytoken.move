module 0xb9673efea8f7884c7f435951f3e1f3d5a6d955323375059323418e545dc561ef::mytoken {
    struct MYTOKEN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<MYTOKEN>, arg1: 0x2::coin::Coin<MYTOKEN>) {
        0x2::coin::burn<MYTOKEN>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<MYTOKEN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<MYTOKEN>>(0x2::coin::mint<MYTOKEN>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: MYTOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MYTOKEN>(arg0, 9, b"LILPEPE", b"Little Pepe", b"Enter the new world order with LILPEPE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ibb.co/N6K9wR6D/0xa2209a2b7cdb0a15457322199fe45bdbad72c48f.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MYTOKEN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MYTOKEN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

