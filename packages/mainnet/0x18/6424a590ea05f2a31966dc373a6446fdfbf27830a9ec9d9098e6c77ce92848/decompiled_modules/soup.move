module 0x186424a590ea05f2a31966dc373a6446fdfbf27830a9ec9d9098e6c77ce92848::soup {
    struct SOUP has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SOUP>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::total_supply<SOUP>(arg0) + arg1 <= 100290000000000, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<SOUP>>(0x2::coin::mint<SOUP>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: SOUP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOUP>(arg0, 6, b"SOUP", b"SOUP", b"SOUP Token on Sui Network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://archive.cetus.zone/assets/image/sui/pyth.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<SOUP>>(0x2::coin::mint<SOUP>(&mut v2, 100290000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOUP>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SOUP>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

