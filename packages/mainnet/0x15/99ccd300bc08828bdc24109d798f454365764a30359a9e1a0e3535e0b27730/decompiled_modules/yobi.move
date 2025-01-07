module 0x1599ccd300bc08828bdc24109d798f454365764a30359a9e1a0e3535e0b27730::yobi {
    struct YOBI has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<YOBI>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<YOBI>>(0x2::coin::mint<YOBI>(arg0, arg2 * 1000000000, arg3), arg1);
    }

    fun init(arg0: YOBI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YOBI>(arg0, 9, b"YOBI", b"YOBI", b"YOBI a unique upcoming NFT collection for the true fans, you ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1551589503961382917/CceW7CxT_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<YOBI>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YOBI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YOBI>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

