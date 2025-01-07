module 0x8d9cce99516073bb0fe59a8d02c0e58bddd1123c3230180e0c658b83103f20f3::maya {
    struct MAYA has drop {
        dummy_field: bool,
    }

    public(friend) fun mint(arg0: &mut 0x2::coin::TreasuryCap<MAYA>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<MAYA>>(0x2::coin::mint<MAYA>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: MAYA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAYA>(arg0, 1, b"MAYA", b"Maya", b"ChakraNFT farming token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://kriya-assets.s3.ap-southeast-1.amazonaws.com/assets/1.png"))), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MAYA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<MAYA>>(0x2::coin::mint<MAYA>(&mut v2, 10000000000, arg1), @0x9f2ebfa8bfb2ab470d776cce2c0ec1e82bedad524ec9e90416c06ecf166b76f0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAYA>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

