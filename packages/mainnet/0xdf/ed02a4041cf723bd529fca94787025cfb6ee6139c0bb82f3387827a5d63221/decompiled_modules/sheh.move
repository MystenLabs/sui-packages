module 0xdfed02a4041cf723bd529fca94787025cfb6ee6139c0bb82f3387827a5d63221::sheh {
    struct SHEH has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SHEH>, arg1: 0x2::coin::Coin<SHEH>) {
        0x2::coin::burn<SHEH>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SHEH>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SHEH>>(0x2::coin::mint<SHEH>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: SHEH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHEH>(arg0, 9, b"SHEH", b"SHEH", b"testing token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"testing token")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHEH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHEH>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

