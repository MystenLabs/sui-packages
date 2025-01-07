module 0xb633be4b9380417c5e1bf58191297a07bc8452a72c9d0d4b844689109438b6fc::YASHOU {
    struct YASHOU has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<YASHOU>, arg1: 0x2::coin::Coin<YASHOU>) {
        0x2::coin::burn<YASHOU>(arg0, arg1);
    }

    fun init(arg0: YASHOU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YASHOU>(arg0, 9, b"YASHOU", b"YASHOU", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ibb.co/s9Wh5ry/yashou.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YASHOU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YASHOU>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<YASHOU>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<YASHOU>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

