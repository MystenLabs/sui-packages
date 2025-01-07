module 0xead92ec6492b9c51ab7dbb079e60d8049062f771951df15f8012d22baeff4c93::unithewonderdog {
    struct UNITHEWONDERDOG has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<UNITHEWONDERDOG>, arg1: 0x2::coin::Coin<UNITHEWONDERDOG>) {
        0x2::coin::burn<UNITHEWONDERDOG>(arg0, arg1);
    }

    fun init(arg0: UNITHEWONDERDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UNITHEWONDERDOG>(arg0, 9, b"uni the wonder dog", b"uni", b"coin based on sui founders dog   tg: https://t.me/UnitheWonderDog  twitter: https://twitter.com/UniTheWonderDog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/SIJpoBb.jpg")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<UNITHEWONDERDOG>>(v1);
        0x2::coin::mint_and_transfer<UNITHEWONDERDOG>(&mut v2, 694200000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UNITHEWONDERDOG>>(v2, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<UNITHEWONDERDOG>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<UNITHEWONDERDOG>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

