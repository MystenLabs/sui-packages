module 0xa22e50e00fb57357a05b7146c19364db21b85278763e3798c784172ffc061528::capo {
    struct CAPO has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<CAPO>, arg1: 0x2::coin::Coin<CAPO>) {
        0x2::coin::burn<CAPO>(arg0, arg1);
    }

    fun init(arg0: CAPO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAPO>(arg0, 9, b"CAPO", b"CAPO ", b"CAPO Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1656230280670109697/Cahfc6Nb_400x400.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CAPO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAPO>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<CAPO>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<CAPO>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

