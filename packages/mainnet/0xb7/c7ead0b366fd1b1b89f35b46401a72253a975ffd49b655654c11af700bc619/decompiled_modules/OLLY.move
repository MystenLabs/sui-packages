module 0xb7c7ead0b366fd1b1b89f35b46401a72253a975ffd49b655654c11af700bc619::OLLY {
    struct OLLY has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<OLLY>, arg1: 0x2::coin::Coin<OLLY>) {
        0x2::coin::burn<OLLY>(arg0, arg1);
    }

    fun init(arg0: OLLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OLLY>(arg0, 9, b"OLLY", b"OLLY", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OLLY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OLLY>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<OLLY>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<OLLY>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

