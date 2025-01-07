module 0xc9dab7fba071655f4b9ecec49725890f31d3ed7284126ca437fa5bb5e4f8ee42::klaus {
    struct KLAUS has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<KLAUS>, arg1: 0x2::coin::Coin<KLAUS>) {
        0x2::coin::burn<KLAUS>(arg0, arg1);
    }

    fun init(arg0: KLAUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KLAUS>(arg0, 9, b"KLAUS", b"Klaus", b"Klaus", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmdKyqu8Dxx5y3gTJwZNZygKp5aqaK2ajHn4XMfv67ZNoS")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<KLAUS>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KLAUS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KLAUS>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

