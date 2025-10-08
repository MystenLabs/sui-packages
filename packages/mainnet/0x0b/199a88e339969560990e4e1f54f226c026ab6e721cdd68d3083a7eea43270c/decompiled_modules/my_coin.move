module 0xb199a88e339969560990e4e1f54f226c026ab6e721cdd68d3083a7eea43270c::my_coin {
    struct MY_COIN has drop {
        dummy_field: bool,
    }

    fun create_currency<T0: drop>(arg0: T0, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::TreasuryCap<T0> {
        let (v0, v1) = 0x2::coin::create_currency<T0>(arg0, 9, b"BUTT", b"Buttman", b"Tumbong ni Robi", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://coin-images.coingecko.com/coins/images/36326/large/kqDFdKtJ_400x400.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T0>>(v1);
        v0
    }

    fun init(arg0: MY_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = create_currency<MY_COIN>(arg0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MY_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<MY_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<MY_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

