module 0x1e0520da63fc212f435a8c7c524533dc274f0a026a28b74e1bf333ce5e3a1426::suitoshi {
    struct SUITOSHI has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUITOSHI>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SUITOSHI>>(0x2::coin::mint<SUITOSHI>(arg0, arg2 * 1000000000, arg3), arg1);
    }

    fun init(arg0: SUITOSHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITOSHI>(arg0, 9, b"SUITOSHI", b"SUITOSHI", b"In Memory Of Satoshi", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1847623101187555328/qebv7Ytn_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUITOSHI>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUITOSHI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITOSHI>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

