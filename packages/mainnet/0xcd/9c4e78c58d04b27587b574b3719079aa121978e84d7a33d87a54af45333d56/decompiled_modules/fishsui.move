module 0xcd9c4e78c58d04b27587b574b3719079aa121978e84d7a33d87a54af45333d56::fishsui {
    struct FISHSUI has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<FISHSUI>, arg1: 0x2::coin::Coin<FISHSUI>) {
        0x2::coin::burn<FISHSUI>(arg0, arg1);
    }

    fun init(arg0: FISHSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FISHSUI>(arg0, 9, b"fish.sui", b"FISH", b"Fish.Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.ethoswallet.xyz/ipfs/bafybeielfvz4m33f3vesmp3kxc2oplp3lmoaq7cu4tq45p5tp3fqdcnkxm")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FISHSUI>>(v1);
        0x2::coin::mint_and_transfer<FISHSUI>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FISHSUI>>(v2, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<FISHSUI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<FISHSUI>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

