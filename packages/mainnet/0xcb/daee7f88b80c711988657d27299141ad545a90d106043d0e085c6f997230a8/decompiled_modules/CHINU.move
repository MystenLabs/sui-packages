module 0xcbdaee7f88b80c711988657d27299141ad545a90d106043d0e085c6f997230a8::CHINU {
    struct CHINU has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHINU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHINU>(arg0, 9, b"CHINU", x"4348494e5520e5a587e58aaa", x"4348494e5520e5a587e58aaa2020", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1746586518766989312/jyzfC6sG_400x400.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHINU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHINU>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<CHINU>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<CHINU>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

