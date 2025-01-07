module 0x521c726b7eb73971b471738a46f7e0093c29171dec62775c40a3c8d4782b83e5::pika {
    struct PIKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIKA>(arg0, 2, b"PIKA", b"PIKACHU", b"PIKACHU COIN ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1745737178116718592/pZpYFIUp_400x400.jpg")), arg1);
        let v2 = v0;
        let v3 = &mut v2;
        let v4 = 0x2::tx_context::sender(arg1);
        mint(v3, 100000000000, v4, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PIKA>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<PIKA>>(v2);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<PIKA>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<PIKA>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

