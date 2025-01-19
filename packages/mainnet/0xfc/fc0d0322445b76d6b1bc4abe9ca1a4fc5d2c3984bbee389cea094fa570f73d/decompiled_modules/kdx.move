module 0xfcfc0d0322445b76d6b1bc4abe9ca1a4fc5d2c3984bbee389cea094fa570f73d::kdx {
    struct KDX has drop {
        dummy_field: bool,
    }

    public(friend) fun mint(arg0: &mut 0x2::coin::TreasuryCap<KDX>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<KDX>>(0x2::coin::mint<KDX>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: KDX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KDX>(arg0, 6, b"KDX", b"KDX", b"Kriya ecosystem's native token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://storage.cloud.google.com/kriya-assets/kriya-logo.webp"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KDX>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KDX>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

