module 0xd0d1ee92ba5b1d7b60a589446939d2fbbc2ac5f29d605922eb9b97dbe06c351::suicide {
    struct SUICIDE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICIDE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICIDE>(arg0, 9, b"SUIC", b"SUIcide", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ibb.co/fCP79Z7/934378-middle.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUICIDE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICIDE>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUICIDE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUICIDE>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

