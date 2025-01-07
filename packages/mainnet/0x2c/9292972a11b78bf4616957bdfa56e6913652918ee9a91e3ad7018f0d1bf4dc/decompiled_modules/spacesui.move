module 0x2c9292972a11b78bf4616957bdfa56e6913652918ee9a91e3ad7018f0d1bf4dc::spacesui {
    struct SPACESUI has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SPACESUI>, arg1: 0x2::coin::Coin<SPACESUI>) {
        0x2::coin::burn<SPACESUI>(arg0, arg1);
    }

    fun init(arg0: SPACESUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPACESUI>(arg0, 6, b"SPACE SUI", b"SPACESUI", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ibb.co/3WLPXgq/space.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SPACESUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPACESUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SPACESUI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SPACESUI>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

