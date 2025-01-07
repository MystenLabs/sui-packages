module 0x941e042c0e11db1c00b2bc882edb614369236fe3512ebef75d6d25bc8d4f4ebb::doodle {
    struct DOODLE has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<DOODLE>, arg1: 0x2::coin::Coin<DOODLE>) {
        0x2::coin::burn<DOODLE>(arg0, arg1);
    }

    fun init(arg0: DOODLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOODLE>(arg0, 6, b"DOODLE", b"DOODLE", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ibb.co/yXrXL6x/doodle.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOODLE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOODLE>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<DOODLE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<DOODLE>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

