module 0xe9e92fe0e8f1e4399a18bea14a0e37c1cf698105981c769cc781c6e7db851dad::bushi {
    struct BUSHI has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<BUSHI>, arg1: 0x2::coin::Coin<BUSHI>) {
        0x2::coin::burn<BUSHI>(arg0, arg1);
    }

    fun init(arg0: BUSHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUSHI>(arg0, 9, b"BUSHI", b"BUSHI NFT GAME", b"A fast-paced & competitive third-person shooter built with Unreal Engine 5.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1567372869218484224/Mi2pwU7l_400x400.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BUSHI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUSHI>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<BUSHI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<BUSHI>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

