module 0x1dcabcddfcd9f5c0250d62a2fd54cde7499a566ba79cc121b37c15e04e65b4f7::t6cbb74c5 {
    struct T6CBB74C5 has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<T6CBB74C5>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T6CBB74C5>>(0x2::coin::mint<T6CBB74C5>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: T6CBB74C5, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<T6CBB74C5>(arg0, 9, b"USAA", b"USAA", b"USAA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.postimg.cc/52kjYb4y/Screen-Shot-2026-07-27-231117-321.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T6CBB74C5>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<T6CBB74C5>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

