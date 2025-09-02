module 0xa38948a819b6d758f9e3176b92257cb386265c4ae5bcfd948a47d23019bf54b8::kyuzotoken {
    struct KYUZOTOKEN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<KYUZOTOKEN>, arg1: 0x2::coin::Coin<KYUZOTOKEN>) {
        0x2::coin::burn<KYUZOTOKEN>(arg0, arg1);
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<KYUZOTOKEN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<KYUZOTOKEN>>(0x2::coin::mint<KYUZOTOKEN>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: KYUZOTOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KYUZOTOKEN>(arg0, 6, b"KYC", b"Kyuzo's Coin", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://home-page-cdn.kyuzosfriends.com/images/icon/KO_LOGO.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KYUZOTOKEN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KYUZOTOKEN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

