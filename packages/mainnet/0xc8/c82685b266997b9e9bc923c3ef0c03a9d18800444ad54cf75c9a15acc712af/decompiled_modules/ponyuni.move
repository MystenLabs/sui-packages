module 0xc8c82685b266997b9e9bc923c3ef0c03a9d18800444ad54cf75c9a15acc712af::ponyuni {
    struct PONYUNI has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<PONYUNI>, arg1: 0x2::coin::Coin<PONYUNI>) {
        0x2::coin::burn<PONYUNI>(arg0, arg1);
    }

    fun init(arg0: PONYUNI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PONYUNI>(arg0, 9, b"ponyuni", b"pony", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PONYUNI>>(v1);
        0x2::coin::mint_and_transfer<PONYUNI>(&mut v2, 100000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PONYUNI>>(v2, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<PONYUNI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<PONYUNI>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

