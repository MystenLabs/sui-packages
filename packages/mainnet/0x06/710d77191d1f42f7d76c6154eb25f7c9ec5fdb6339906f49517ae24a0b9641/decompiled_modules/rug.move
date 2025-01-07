module 0x6710d77191d1f42f7d76c6154eb25f7c9ec5fdb6339906f49517ae24a0b9641::rug {
    struct RUG has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<RUG>, arg1: 0x2::coin::Coin<RUG>) {
        0x2::coin::burn<RUG>(arg0, arg1);
    }

    fun init(arg0: RUG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RUG>(arg0, 6, b"RUG", b"RUG", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RUG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RUG>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<RUG>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<RUG>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

