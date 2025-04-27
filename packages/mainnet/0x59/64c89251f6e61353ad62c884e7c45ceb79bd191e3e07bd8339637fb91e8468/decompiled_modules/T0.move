module 0x5964c89251f6e61353ad62c884e7c45ceb79bd191e3e07bd8339637fb91e8468::T0 {
    struct T0 has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<T0>, arg1: 0x2::coin::Coin<T0>) {
        0x2::coin::burn<T0>(arg0, arg1);
    }

    fun init(arg0: T0, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<T0>(arg0, 9, b"T0", b"Test0", b"yolo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcREH8eOkHxsELIF5Ztbh9Q5_SznwHUU3bWncQ&s")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T0>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<T0>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<T0>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<T0>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

