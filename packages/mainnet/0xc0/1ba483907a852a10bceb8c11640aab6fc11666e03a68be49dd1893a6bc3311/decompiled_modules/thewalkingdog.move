module 0xc01ba483907a852a10bceb8c11640aab6fc11666e03a68be49dd1893a6bc3311::thewalkingdog {
    struct THEWALKINGDOG has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<THEWALKINGDOG>, arg1: 0x2::coin::Coin<THEWALKINGDOG>) {
        0x2::coin::burn<THEWALKINGDOG>(arg0, arg1);
    }

    fun init(arg0: THEWALKINGDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<THEWALKINGDOG>(arg0, 9, b"the walking dog", b"the walking dog", b"https://t.me/thewalkingdogesui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/SzsXyg1.jpg")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<THEWALKINGDOG>>(v1);
        0x2::coin::mint_and_transfer<THEWALKINGDOG>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<THEWALKINGDOG>>(v2, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<THEWALKINGDOG>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<THEWALKINGDOG>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

