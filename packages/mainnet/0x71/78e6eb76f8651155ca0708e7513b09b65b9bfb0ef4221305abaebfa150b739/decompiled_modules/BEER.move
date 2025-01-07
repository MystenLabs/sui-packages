module 0x7178e6eb76f8651155ca0708e7513b09b65b9bfb0ef4221305abaebfa150b739::BEER {
    struct BEER has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<BEER>, arg1: 0x2::coin::Coin<BEER>) {
        0x2::coin::burn<BEER>(arg0, arg1);
    }

    fun init(arg0: BEER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEER>(arg0, 2, b"BEER", b"BEER", b"BEER on the Sui blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.dextools.io/resources/tokens/logos/ether/0x0d58df0929b6baf8ed231f3fa672f0e5dcd665f7.png?1684143314546")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BEER>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEER>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<BEER>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<BEER>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

