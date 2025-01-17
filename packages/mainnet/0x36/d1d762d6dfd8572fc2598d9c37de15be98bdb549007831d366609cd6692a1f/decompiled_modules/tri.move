module 0x36d1d762d6dfd8572fc2598d9c37de15be98bdb549007831d366609cd6692a1f::tri {
    struct TRI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRI>(arg0, 10, b"TRI", b"TRI token", b"The official token of the TRI project", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://storage.cloud.google.com/tricoin/tri.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRI>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<TRI>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 <= 18446744073709551615 - 0x2::coin::total_supply<TRI>(arg0), 0);
        0x2::coin::mint_and_transfer<TRI>(arg0, arg1, 0x2::tx_context::sender(arg2), arg2);
    }

    // decompiled from Move bytecode v6
}

