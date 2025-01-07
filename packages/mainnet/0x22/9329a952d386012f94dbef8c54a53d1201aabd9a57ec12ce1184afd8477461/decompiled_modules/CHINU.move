module 0x229329a952d386012f94dbef8c54a53d1201aabd9a57ec12ce1184afd8477461::CHINU {
    struct CHINU has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHINU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHINU>(arg0, 9, b"CHUNKY", b"KitKat $CHUNKY on SUI", b"KitKat $CHUNKY on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1746490675481210880/A12ZQSuA_400x400.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHINU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHINU>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<CHINU>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<CHINU>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

