module 0x8a136f3cbff331fcf09a779ba9dd2bd96a9c69d0252846993406750f47c64e72::Dragon {
    struct DRAGON has drop {
        dummy_field: bool,
    }

    public entry fun burn_mint_cap(arg0: 0x2::coin::TreasuryCap<DRAGON>) {
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRAGON>>(arg0, @0x0);
    }

    fun init(arg0: DRAGON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DRAGON>(arg0, 3, b"DRG", b"Dragon", b"Dragon: The Memecoin with a Dramatic Twist", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://zkevm.exchange/images/dragon256.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DRAGON>>(v1);
        0x2::coin::mint_and_transfer<DRAGON>(&mut v2, 168000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRAGON>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

