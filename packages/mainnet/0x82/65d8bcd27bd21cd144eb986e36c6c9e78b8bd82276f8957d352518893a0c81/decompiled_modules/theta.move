module 0x8265d8bcd27bd21cd144eb986e36c6c9e78b8bd82276f8957d352518893a0c81::theta {
    struct THETA has drop {
        dummy_field: bool,
    }

    fun init(arg0: THETA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<THETA>(arg0, 9, b"THETA", b"theta", b"I will crush you. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://kappa-dev.sgp1.cdn.digitaloceanspaces.com/kappa-dev/coins/9928cfac-a06a-40b3-bb9d-68d0e5ac9891.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<THETA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<THETA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

