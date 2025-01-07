module 0xe1f4e1a08dfee9fcd8df8b5cff6a42b798efe23da9d227b8ef6bab04635c332d::thewondershib {
    struct THEWONDERSHIB has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<THEWONDERSHIB>, arg1: 0x2::coin::Coin<THEWONDERSHIB>) {
        0x2::coin::burn<THEWONDERSHIB>(arg0, arg1);
    }

    fun init(arg0: THEWONDERSHIB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<THEWONDERSHIB>(arg0, 9, b"the wonder shib", b"the wonder shib", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cryptologos.cc/logos/shiba-inu-shib-logo.png?v=029")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<THEWONDERSHIB>>(v1);
        0x2::coin::mint_and_transfer<THEWONDERSHIB>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<THEWONDERSHIB>>(v2, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<THEWONDERSHIB>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<THEWONDERSHIB>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

