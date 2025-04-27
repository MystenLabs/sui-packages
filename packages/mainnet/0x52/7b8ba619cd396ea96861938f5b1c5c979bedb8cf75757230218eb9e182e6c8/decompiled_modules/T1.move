module 0x527b8ba619cd396ea96861938f5b1c5c979bedb8cf75757230218eb9e182e6c8::T1 {
    struct T1 has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<T1>, arg1: 0x2::coin::Coin<T1>) {
        0x2::coin::burn<T1>(arg0, arg1);
    }

    fun init(arg0: T1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<T1>(arg0, 9, b"T1", b"Test1", b"yolo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcREH8eOkHxsELIF5Ztbh9Q5_SznwHUU3bWncQ&s")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T1>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<T1>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<T1>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<T1>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

