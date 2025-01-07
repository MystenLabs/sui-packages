module 0x668a20453faaa8cbbcd1d560199a950a2eab735a8b8a2e1a5c17b6f028fec5ee::MEOW {
    struct MEOW has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<MEOW>, arg1: 0x2::coin::Coin<MEOW>) {
        0x2::coin::burn<MEOW>(arg0, arg1);
    }

    fun init(arg0: MEOW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEOW>(arg0, 9, b"Meow", b"Meow Sui Finance", x"f09f90be4d656f7746696e616e6365206f6e20405375694e6574776f726b3a2046656c696e652066756e20696e2066696e616e636521204a6f696e2074686520707572722d7265766f6c7574696f6e20666f72206120756e697175652063727970746f20657870657269656e63652e20f09f8c90f09f90b1f09f92b0", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1749092043412881408/xc4-A8-0_400x400.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEOW>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEOW>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<MEOW>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<MEOW>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

