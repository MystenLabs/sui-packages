module 0x65772d30737ff842f5f53018617339393abc8baf5b2392a9bdae00f2e53f6448::shiba {
    struct SHIBA has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SHIBA>, arg1: 0x2::coin::Coin<SHIBA>) {
        0x2::coin::burn<SHIBA>(arg0, arg1);
    }

    fun init(arg0: SHIBA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHIBA>(arg0, 6, b"SHIBA SUI", b"SHIBA", b"LETS FLY TO THE MOON", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.postimg.cc/W4RkKS38/Desain-tanpa-judul-1.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHIBA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHIBA>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SHIBA>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SHIBA>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

