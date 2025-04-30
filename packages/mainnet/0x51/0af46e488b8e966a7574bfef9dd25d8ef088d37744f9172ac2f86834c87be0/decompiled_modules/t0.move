module 0x510af46e488b8e966a7574bfef9dd25d8ef088d37744f9172ac2f86834c87be0::t0 {
    struct T0 has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<T0>, arg1: 0x2::coin::Coin<T0>) {
        0x2::coin::burn<T0>(arg0, arg1);
    }

    fun init(arg0: T0, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<T0>(arg0, 9, b"T0", b"Test0", b"yolo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcREH8eOkHxsELIF5Ztbh9Q5_SznwHUU3bWncQ&s")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T0>>(v1);
        let v3 = &mut v2;
        let v4 = 0x2::tx_context::sender(arg1);
        mint(v3, 1000000000000000, v4, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<T0>>(v2, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<T0>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<T0>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

