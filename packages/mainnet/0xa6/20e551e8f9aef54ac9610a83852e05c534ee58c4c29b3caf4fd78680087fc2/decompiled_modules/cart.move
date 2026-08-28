module 0xa620e551e8f9aef54ac9610a83852e05c534ee58c4c29b3caf4fd78680087fc2::cart {
    struct CART has drop {
        dummy_field: bool,
    }

    fun init(arg0: CART, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CART>(arg0, 6, b"CART", b"car", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suipad.online/api/images/d115c66a309b966d17229fb755df68ce7ff3e85bb19a875890ef10ddcd75e1c9.jpg")), arg1);
        let v2 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CART>>(v0, v2);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CART>>(v1, v2);
    }

    // decompiled from Move bytecode v7
}

