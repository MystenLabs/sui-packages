module 0xc1e836c013aa37b8c3959b82a896088819798f82ae283a1185284a2f9d0fef55::banana {
    struct BANANA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BANANA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BANANA>(arg0, 9, b"Banana", b"FIAT Mon(k)ey", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmbXXctuyRa6kWBwTivvJoZmPComcJU4rW4zMYXa67nK7m")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BANANA>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BANANA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BANANA>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

