module 0x613fa7b0b2781015cbe5f31fd16e40755c73b14f9d52480df5539db91ef6f283::wagmi {
    struct WAGMI has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<WAGMI>, arg1: 0x2::coin::Coin<WAGMI>) {
        0x2::coin::burn<WAGMI>(arg0, arg1);
    }

    fun init(arg0: WAGMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAGMI>(arg0, 2, b"WAGMI", b"suiwagmi", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WAGMI>>(v1);
        let v3 = &mut v2;
        let v4 = 0x2::tx_context::sender(arg1);
        mint(v3, 100000000000, v4, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAGMI>>(v2, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<WAGMI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<WAGMI>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

