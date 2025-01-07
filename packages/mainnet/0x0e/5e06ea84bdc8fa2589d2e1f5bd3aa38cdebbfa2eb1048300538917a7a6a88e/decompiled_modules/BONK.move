module 0xe5e06ea84bdc8fa2589d2e1f5bd3aa38cdebbfa2eb1048300538917a7a6a88e::BONK {
    struct BONK has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<BONK>, arg1: 0x2::coin::Coin<BONK>) {
        0x2::coin::burn<BONK>(arg0, arg1);
    }

    fun init(arg0: BONK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BONK>(arg0, 9, b"BONK", b"Bonk AI", b"BONK AI OF SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ibb.co/J718S4G/bond.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BONK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BONK>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<BONK>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<BONK>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

