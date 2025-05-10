module 0x67c6334f2235df0175f195db96d9c6dd2bc50a10acc46b81330f0c16510e621d::testtoken2 {
    struct TEST has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<TEST>, arg1: 0x2::coin::Coin<TEST>) {
        0x2::coin::burn<TEST>(arg0, arg1);
    }

    fun internal_init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = TEST{dummy_field: true};
        let (v1, v2) = 0x2::coin::create_currency<TEST>(v0, 9, b"TEST", b"test", b"This is a test token, do not buy!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ibb.co/chX1zR5j/images-q-tbn-ANd9-Gc-Rm-Dwyc-Vz-Cs-Wa-Zx5-Aa-CTeqz6e8q-Lbt8-Ua-Qz7g-s.jpg")), arg0);
        let v3 = v1;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TEST>>(v2);
        0x2::coin::mint_and_transfer<TEST>(&mut v3, 10000000000000000000, 0x2::tx_context::sender(arg0), arg0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEST>>(v3, 0x2::tx_context::sender(arg0));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<TEST>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<TEST>(arg0, arg1, arg2, arg3);
    }

    public entry fun start(arg0: &mut 0x2::tx_context::TxContext) {
        internal_init(arg0);
    }

    // decompiled from Move bytecode v6
}

