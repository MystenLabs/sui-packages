module 0x7e0da8782cc0947a7425c6ba499b005fc1df77a3aeaa4089ea1b96a756e0b022::pepe {
    struct PEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPE>(arg0, 9, b"PEPE", b"Token PEPE on SUI", b"Testinggg....", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://storage.slaunch.xyz/staging/tokens/edfe0890-79eb-4871-b3ce-266836604bf3.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PEPE>(&mut v2, 10000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

